(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -ev

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# Pull the latest Docker images from Docker Hub.
docker-compose pull
docker pull hyperledger/fabric-ccenv:x86_64-1.0.0-alpha

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Create the channel on peer0.
docker exec peer0 peer channel create -o orderer0:7050 -c mychannel -f /etc/hyperledger/configtx/mychannel.tx

# Join peer0 to the channel.
docker exec peer0 peer channel join -b mychannel.block

# Fetch the channel block on peer1.
docker exec peer1 peer channel fetch -o orderer0:7050 -c mychannel

# Join peer1 to the channel.
docker exec peer1 peer channel join -b mychannel.block

# Open the playground in a web browser.
case "$(uname)" in 
"Darwin") open http://localhost:8080
          ;;
"Linux")  if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                xdg-open http://localhost:8080
          elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
          #elif other types blah blah
	        else   
    	            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
          ;;
*)        echo "Playground not launched - this OS is currently not supported "
          ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� C�%Y �]Ys�:�g�
j^��xߺ��F���6�`��R�ٌ���c Ig�tB:��[�/�$!�:���Q����u|���`�_>H�&�W�&���;|Aq-~)�� (����9�y�M���Z��:�����r���C�>���i7���`���2��q��)�@*���������@�X�B`D%�2�f�_�S\.�$�J�e�B�߽�W쭣�r�h5���/���u������O�4Zɿ\���:�2�L��O��Q�A����P�أ���(IS_j�Oj�#��?����ʽ������]��]�<�l�%l�.&1M�Iظ�E����OS$����Q����O�7�g��
?G�?��xQ��$�X��E6��������:��Zy�j=]6�!�ڢuʃ���Me�w٤�0	���
V�ׂ���ikA�*̄Բ�O�4q��W��B���f<�-�x�X��I�	ܑ�㹉�S�z�B4�Y��|��,=�N�R7��@��4}������@�e����E/�P׾}�N�U����;�7�/�ۋ�K�O�?w/��(����J�G��.����:��xE���=��8]��R�@��nȒ�j�V��2�4x���2BYS����ޖr<k.�m�h�ͅ�j2�u{�&�*Z�C�f	��5ļe��7�@�9��aRf�[7"��
��򸝢0i#��=də=Rg�A���?<Qd�a.�9�ĝh��&�or���s#w�p�W%W�׃�(f<�H����>-�������7Me'��k~�N��"r����;i�<��"o�5�H�X��`a�}� ď�������E�I>�{o-�+����g��x�P����P�ȀS}U���ÛC����F�v#a����+6F�L��~�A�ڀv�,g%�U.܎Pޕ��e��(nugJ7s-j6:p����{B.rp��G�'3�;�A�_�� \�_�[ix⹰� ����"ב.�ˢ�N�rІobd��<�� �-��hӁ����H���Jy`2��E��#�ס��L�Il�@�0�"�l�Qs^?���߰����!���-���&���>d�b��F<g�x��r]�a���l���3����Ϧ���=��b��������6����>���	*�/��8+�߉��_j�a�l���j�����y·�܎��a���D�Џ�B�~Ĩo'T�CR���8(�X\L$�H+�앙{��H�?�������J�gF�D���d�{'ZL��%p�k�9jXC"ԗ������ۻ|��,�{��c��"�s1����V���( ͽ���K���2��]�թ� �����&́�l���9�zKӔ3#gh�ˋ,�?�|^ o�Jf��rB�=<�!�|-�t��������L^��B>J$��O��� ׁ��C�(��3�f&$���	I4��������5�/����&�f,O`@�Ϲ)��3��%��j���Ur(q��C�����%���o`�w���$���R�!������=�?B�X��e���+�����\{����c/���#�+�/�$�ό���RP��T�?�>�I���D1�(�-�N�S$[�:ASv@ ,и�`.�P�.J(F�GzU��߅2��������@+��\�÷{�`?�hR��Ñ�z���:�%���# �����2�^��Y��l�V0#&㆜4M��2��[��a=���j�K�9��n��vdA{0���m-��v���
��%H��,e{V�?��/��ό����K�G�����J���j��Z�������w��ό����|���H�O�������L���7s(<:��P�қ�]���O������.:6K}o������`p�{�i2����U�>2�2<�$�zo*ͭ��3A>���w���]����t�x�͆�f2o�z�D���D!P����]�p�r'�v�ó@�D�s�m�ȸ��IG�^p ?G��qڠy��)�8�9@z��%�i�V��ڹN�M�|��6Y��.,����μ����´gOM��@�$0A����^��Y��h1	�x�� ��i��=SZ������SMG��v"FR>�9K����Ё��yW 'Y1�������)~I�b�AW�_>D���S�)��������?�x��w�wv9���*�/�����?F/+�/�W�_������C�J=��HA���2p	�{�M:x�������Юoh�a8�zn��(°J",�8, �Ϣ4K��]E��~(C����!t�.*��\��2aW�W���X�plNl����{���6[�A�z�^��C	��yܩ�JJ�E�Il/��j����hc7�1c���������<D i�l0h�C���<�甒S�ݬ��{7��8���Ï����G��_���������S�߱�CU������2�p��q���)x��$޾|Y9\.ǨJ�e�#���vЋ�_�������wX��p���O�Z�)�2�Y���ň��ǶI��)�B]�B<�`Y�����w]7��%� p|�eX��JC�|�G��?U�?�������Aj�h�(��P�A����0�.���]#M���/���4���v]wW����s)���aDn5f����Q�5#���n��������j=qMP��	ff�^���9�_���� +����JO�?
�+��|���}i�P�2Q��_��
e�4��(
T�_x-��}������?w�J���U�k,a	�0�������G��,	��3���s�=�J���.�j�u#}�F��;���@7�G�@CwA��h�A���vn�8P8��G`�t����t�v�#�|����mc�y[�ȵ�f��#<���39��&���k�͛#���L�-��%��f�f�����'�n��(F�|d���A7��:���6��9Z��5��nM]9�5��	+�����Bm���_�SI�;�!qk!̻��!@]�Hr��pY�n���a���&8L9��Ӽ��+.��Sh+��mg#���s�O	+g�O�� r��A 5Ý�i'�I�D��?�}z��Vu}�Ț�Ґ^<�G��������Ǳ��/���O���7�s��r+7�D������@����R������6���z��ps'���B�ó�ч���7���3C��o�<���� o�2|�z����k����&>q[��'�A@�H���PwSR������ؚ���ms�ѷl���D��!�5S9v-Mhҩl�$��ԺN�t-�\9N�j�x�<��o?�l�C�����}�@�,4GN�F��Y�ͻ�����2�g�d5���ן��v�^�=�K�^����w:��M!��#Z�������g�?�G��������Gh���+���O>�������Ϙ����?e��=���������G��_��W��������N�����
T��\
.��������QU�����+��������b������T��V
.��#l��0�D)ơH�p�g0�D|g4�iGp%2`}*�}�\sëS`~+�!�W���BR��O)�`�PZ�d��a�2�f�����9��6ض��"o䑶hQ����hN�m�`]	otw�K��#`����;VaDI�1�ַ����0�k�d=�(G��b(���:�b��W��/v�~Z��(�3�z->�?���i����_����l�4+����_�_���v���W�Vsm�x�զ��_k�}�����N:u�\�뎡n(�
�F��+{�L��g��v����_�ϕ�jW5	p������U�o��v��zul���>���:�^ǿh�$����V��^z_k٤v���zZG�(�u��H�>�VӅ_{��O�C���q�h��/��NΫ]9������I�W��;u�6^l"�A]×�����Oq��˵=]���Ҏ�Q��7w�AE�[[�v�<-|��ʰ�-v���ꂨ��MCTEtn:r�U ���C�O?/�>^�r_�fW�v��kE%��|��^�q������\;�BϾ��.:J�'ߺ�o^--���DYrg��X����}�u��Y�E���K�2iA���^ܛ������Ӻ8�?��n���6��5x���ߟWe���?��ǒ߿���4����NM��t>]�7�4�Z��d�qb�'p��p8]O6�u��~0�I�^�=L|�	�!�#%pVϧ�� }T�#����Gdq�S7�X=��^��2)���7|�*��q$�C4dE��o��y\VGƷu��'�J1g�^WV�o��t���I��᭝��f	�-����D?}�'㶘���q��ۻ�X��:����\�J��.c����K�u/*�u��u[��)��t]��[{ڽԄ�`�K��I����D?h�/�%�A�!Fb�~@�n��ζsv�b���ӵ��O����￿�y�b��y0����M���i��������lt1<�d�$3�X�R2��q�ږ�c��'�k ��0�/����n�LˁiVFǢK��0н@4�׀�}2��lnr(aƅ|��yGU�$����C��m��hNԍ��+��Ah�ef�tðJ�@������8X�1�Ȓ�mE�uS�F�ޱJ�3v��qf�zxN�CI���3��dG:��B��LS�n9���^��U�#��!���q����8sq\��CS1��ȬJ�?P��-��oֈ�9|r��xiȘuTx�oU�K��nݜ�E��Y���Ma��M��4�"G�ӥ�l8���hpꛃS�N��N''F~0��|D��uru�N�_T$v �r�UY���`.�u���=�9��jL]�X�A-���,�n"I��,�T�>��V�?d9N�.[<g�tJ��a�yߌ�.#J#����_3�F?�+�ѽ^�ԚbTaFw��A�Y]}(�����%w���:L�Y)c�?fH�z��g �+V����Es��E�R$yP`k�lͼ�����r�������W?���޾���Q%�ق�p:�Xa��ι �g��{p�!���O�,�9����ҭ#2d�c�ǚ����.#&h����Lc<�M��N��ڹt|��w��j�2�]]��dC�ע��.�h�B��k�sˮ�܁�S��^UM���٧<4�7�":�Wv������,l���������5�������������^���@a��Ʃ�����ϯv^k�ą�������� 6�"�^�_��Q7��ey4�z=۾jե�
���x8?�y8��3zx�N�;t���kw���?\��Z�|��C�)~���]z�ϟ�^��3حt�	
��\3�C?tB��	�n\z�΍�W�Ϝ��}z�����<���M���M�{��Ma��H֧�y����#rދ�\��r=����F/aL�5�	���xa��B�`h��o3�QX��7, �|��6rDr3o��X��;��%����������2\��4�S�{��Ks�|���z�&��a�2�|=8���fn1/$>g�ۜl�,�I"�6:��s���*�a����t��v����d��"Y��no͢ʤ����il����LH���V��{�o��\�r��bB�3p)(��BB�*��L�l>��^JM)p�뭗B���~�>��S6�f��L�U����"�v�@Xj_�Om�#���'8$�f����bX{j���[�[��kJ6�ƃ��VqW<�$��6�.s����8��+�(Dsy��V�'�ܑPR̄�l��'$ q8d%�a�I#�r
fZp$B�H��Z>�!���1��9d�;�M����V!�Jj���v�V,�#�?�4Y��y�ZJ�Q�\����a�����`��N��\��w�C>?�D��F��W��1)˒Xg�e˝��u�@�Kq��R2��D���L~( �j�@�~�kE��`�n�H�_	��X1��T��D[i�"T�����MNYpF��ZQ�"t�����i��3-)5�,{�gd�*KT��!_���}C�к|�nX9��0vu"Q9�	Ǜ��#����bλU�~p	�T2R�#�&S��
դ�K�}�����*Kl���(Ke���,Q4��
��*\%I��B����Bg�5s����4Ϸ��P�jW�Eyk'�N+�*op;�;�Ĥ� r�}8e	�ɚDp/��2Hz#LʕΔ9�S�=�3�K��	m�ޡ�{[�Z��BI`�7�ҽ��� XB�y�	7�C��[ �ِ���kM�kR��)�=C1�M�l9�nO��i0�)����l����V��6N�F�Os����Zk�}:�v%��A���'֮�8]7�*me��tr買O�Y��L�Y�r��4�VU��]� ��D#�.w�Ѝ�5�j����,���B���A)Y�q�&�Fp�q���%itr�Np1�)�y���̯�6U���~�oi-;Pxh:Nj�$["Np�ٚLm�C7C�����?��}�a�u�N�s�Bg֮�����	K��!hP �T��-�n��ׅ���TyV�Y2��2�������4�(z_�*|�<�2dV�H?�<���-N�U��9�� ���H�����1����!��8�������m}�<���~)X�������Ik�A�EJ=S�b� ȷ��-�Vvn�A���ԑiK�E��Ѡa.:J�p�����,88q4�Q��
���t��"�{����H��p�CS�R�R�_$����(X��]�	�#�--���V����� �y�DP��#[L)��u�6Y��W�Ջ�`��=�*�F�`�@P��)0ZLP��	
i�?���4n�=jb8D,K�$S��CD��x&:����z+1�h��#�F��`�/���;��"]��+CoKAEg���8W�^�|�|cs�hC���T/&[��ER��GP]�6�� LR��r8+70}\�i�^:�����6�8l�8��u�zIwC��N�-S��i�;&�9&>ӊ9˳��C�u*���i+î�;��zX���������}Y<,;������:�d��#l��$�rW�$�c^v��)�����,fPy���8V��3A�IL5(2iE��5eY���0�pyg0aԦ��Ĕ�CdP#����Ʃ-W a�;J��)1-�(L ��%�FH�ܞ.��ax0���p���*&����`��X8l0d7B��yd�]"5����Q�wP��䐨+Q��W���y���bYl�#�����^)U���,���e��F�0�"teK.��w��aMLlI8�st�%y�\/�"�N7��j�)컴���m�q��ǡ��l�o%��}h�l&�
���Br+��6.�[Ͱ]�m�QVk-!�V;\����µ���)��qD�TT^�xM���3|^K�<X�K��߂؄ h��Dq��w���z��8��$�y��N@WXn�E`1�^}�on�^�����^z������������5�aͮ�=|��nv�M'�s�?Q���?|����,	87�>���<Hw_z�������oz��7���'������'����Sq�8��[׮4�~�W&W�t��FӉjh:�F��W~�c�|��;���8=�x�7���=	�N��(���)j�N��Yj�6�Ӧv��N�&`�lj������H�i��iS;mj����>����yh��e�^8�r��%���,4�6y�m!t�����o=fb褏���!��<��5�E���n��3�?�ڟRm��m�q�g<�#p$���d��zmj��2O˞3cG[�93�� {Z�=g�6�8.Ü�#��=���13��q��Z[����G���y\�R�����v����d��m�/���  