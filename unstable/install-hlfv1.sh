ME=`basename "$0"`
if [ "${ME}" = "install-hlfv1.sh" ]; then
  echo "Please re-run as >   cat install-hlfv1.sh | bash"
  exit 1
fi
(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -e

# Docker stop function
function stop()
{
P1=$(docker ps -q)
if [ "${P1}" != "" ]; then
  echo "Killing all running containers"  &2> /dev/null
  docker kill ${P1}
fi

P2=$(docker ps -aq)
if [ "${P2}" != "" ]; then
  echo "Removing all containers"  &2> /dev/null
  docker rm ${P2} -f
fi
}

if [ "$1" == "stop" ]; then
 echo "Stopping all Docker containers" >&2
 stop
 exit 0
fi

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

# stop all the docker containers
stop



# run the fabric-dev-scripts to get a running fabric
./fabric-dev-servers/downloadFabric.sh
./fabric-dev-servers/startFabric.sh
./fabric-dev-servers/createComposerProfile.sh

# Start all composer
docker-compose -p composer -f docker-compose-playground.yml up -d
# copy over pre-imported admin credentials
cd fabric-dev-servers/fabric-scripts/hlfv1/composer/creds
docker exec composer mkdir /home/composer/.hfc-key-store
tar -cv * | docker exec -i composer tar x -C /home/composer/.hfc-key-store

# Wait for playground to start
sleep 5

# Kill and remove any running Docker containers.
##docker-compose -p composer kill
##docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
##docker ps -aq | xargs docker rm -f

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

echo
echo "--------------------------------------------------------------------------------------"
echo "Hyperledger Fabric and Hyperledger Composer installed, and Composer Playground launched"
echo "Please use 'composer.sh' to re-start"

# removing instalation image
rm "${DIR}"/install-hlfv1.sh

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� ��>Y �<K���u��~f��zVF���٭�L泽j�Էg2��i5����ɘ�J%�d��(i0�撋	�r4 �i�s4�C��s�K�����HJjI����3*�[Tի�^�z?�GmM # iC]3Q@W�i��Fj{:T����%;�d,\�t
Q����$��(�]���D��edZ��5�ǲy6�y���e�S���.u cYB�  ��� ?;�TK�Ud<U�!z�lu���u������ �+*��a�J�n<>p��u�:�M"�Z �y��/s��l>�̤�/�>[>A�o��8R,VSU$YxPC��
�?����[�,�?_�!m��v'\�ق�I��}Γ)��p �'�I������,8�<&O7д**eK3\(���R��~�#0H�t�0�+ڴ&ʖ ����du���)�h#+n}�Ѷ9;k�F���5t�A̱죉8����� ��[�?ߨ{r�'�'�Iu���/�����I80y�K���iItf|�jϲt̪$nr�~����秐��%�e��2�J�hEh�྆���贺,1�16���	]H�����f�6�-��%M�����C�5�\^�����l���IE�����]��Q��B�**���Ϟ�a�7홯�x���8�8���k���X,rV�w�2�G�!��8�#���-���[��B���l�V���W�������)_ȝ�h(��5���v��U�[�-Y%Z���d�rvF��A�'Zp +
�64�P#\��1RUY�$�&Xv�I�~�>x@�|t�^�U!��0p|���o?+�����G��O:(U쌑�Ӡ?��9�EL�4?�w�/ ��PG��8w��˧�tdL�Z'.�R�Τ^r� ���a���}�H1���*57K6�hBaK�y ��
'Lϡ��l]v�3��}Ӳ��
���f���~e�P[2tO�,��f�d�����Hz�?�J�<?��E��L]���xNm_�\mq�uZ��hb����atől����~�Z=,(ʡG���DA)�� �=Y�A������G��=WA��
��RG03���!�戦*�Ug�����s�C̄�V吼��,S�M�]�za�@������K@O4OwpY�ph"[�zd�hk*zC�]Y+[⿣D�9�j���s���������p�Y��û�e5���Ȑ�U���v?ڲ�9�������=b���;P����x�^'Sܹ�߫����������,LEw�eg�ovy���7j�����������ek�/��|8��Cdp3��EB;�������JdJ�^	���C(�xB��:���>�c�K����y����%�Z���w�_�\:�Sdp��5e�����O��5�8���0ی�����j��G�@c�h�s��ۙ�N-��f8�<��6��ch
���Lb�۠��{$Y�1/�	�L�i�-e
£c߄�݂��wuJ������ ?���n�f���$͔2��*W*g���-���� �M8RMd}E��	,?qN������ RLt6N���
�{{�	3��T��,�%ᩐ�|E8��5�m��x�Dx����SCX����xcp�����=���vO�a?����[	?�	�m ��	\nG�Kg�� �4�P[���/�P�-)H:}��3�M���ź��.�Si��o��k���	b[����^������p�؝���r�����1�'��$���_E����ʦ�y��F6柊D�]�we���DaM�1�0-�C3>��!��;5�8��N������Kg��7���=.��G��SjC�۳`k��a����Ks�,�-��.��@�4��܈qO���.j���)|��ǰ���(��������_����@K���B�O:o�ީ�}�8���^��4�j�ÃI<�4����`@T��x^7I|�NR�/�o~!�e(j#��nm�y��_��_eS�<���6�C����ߕ��]�?/�;kSN�95-4��o0/�Dv��8��B�_�+ǓM�� {)p�с?!��� O.��mC϶<hx���C�����e��%��kJB.������y���f��b�n��J��~��ݤ_6w�%��th;#�Ey�6���Xtm�ɪ{�_�x�4��C��N���K�~��������"%o��o%|���s`*�g�b�Xw�כ83��}�E��&H���K@o�48�U��]���ҭ#VY�~+\��]kB,�����͡&ω;\a�\^�N�@��~��{�כֿ�mZ��<��\��q�p�k̓�2O^�y����������yQ������q��?2�����\z�W��4�?|��P!2�9�a�Y���������g�v����^������񿿜��~�";T,vH\��lEB�N,�⭈�Bb$܊v:�`$��ɰ#���p�0�A��������鿃?��N�o�z����|�?��?��6�ʂ�7�������<��W~�|��+_.��哛�1�����Ǿ���������v�)��� ˕�L2����>�a�>��%�K����^�f��LVkff� ���d���L&E���>j��������9��tO��d����;���[�]���5�T��n#Q- A[ciXR�au*�U>�4y�O1��T��].Ų�g�K���d��1f���ΐT��^�hT&פz��^�H��r���X-��J��T����=njve���I��<�>�'��Y5/��}f1�6gsa3<�`�N���x�E�v)�g��d��`4>N����!�v�g�I�x&�"���ψ�x,�im9F��Y:إy��f���M�K�t��{�z7��)�fX�U;�=4�=�f�BG�f���4���&�͙��feE��@�H�(�D>�7Y:Ah�G�� .�8���{��a�V�6�)M7S��f����7��A�����4�9�H�>w��;p5���l��O�]b��*�$��\��R�X�Fb��$�t�k��D��L
H��A)��$t����ژ�N�j��4Y�4�>Q4�j�@����f�Op���r���릸n���e�jL�}�j�V�_�m��b�p��h�&zsx0m�_j�I�mKs6)4j�nI=쵆9]�rc��Zv�5��k��Kk��@��JǽA?_(f�۝?�c�X�.�ʢ0�j�N4�u�K��0�qD?��������� ]��9��D�ĘS�j�-�+i=G��V�>hgf�zH�u���u��;r �b�1�UY�a'l�8<�6�mp�3��p��{��)�	���c �nQfX&WV%9Y��M!���� _H�:	z/yT�Dƅc�ƈ����b�������t��h���+N�x�MO���P$�G�dӴ��j���qk��l��љ.�����&�V5�:����E
�l_D���8�+�3�T�T��bc9�ö��;��r3�����H��;����k%���M��٠Y��g=�$$��D9]�u!E��F:t�(P�+-�=h5���FL�#2��BE&T�&C]+��.o#%�앹�0��jNI��^γ&��Q�D�����%�TY��a�#Ny��5عc�<+=J��ihrpX�$a$�Q����V]�7�R�X!��qٌ�2G�\�KR{4���l,uJ���[���Քt�HS�D4/��oVY�פ,���*�U��d7�lE�%#���4F�Q*Vg]�ڱ�P=V��4WeF�%�ꤝ�r�zA��L�(��m5��V������唅.*|լ+���
��y>Z��eU)�R��5�3�%m��D�>	���$k�Q�Wk�vP1�q"8J�5!��M��2�u��qZM�C�1���#+�b�j�:y*���&RGg��7�,�m�2٢,�+K�ʒelT̒�a[���I*&�n.ۛ��܌�wG3sXi��"��R��̌�����q����͎x4��CGf�A(�u9e�zyY�LSt$d45�����`�ܔ��)e� ^�=SY��="2�Ƒ}(��6�.��S���1y��l�r_!q��"�(�q��O̡!Y�R��k���=��"�9*����)����r�]�v�������x�f�2L�=��׿���{�u���|�]}�^v
����3İ?\�s���j��Z%UB�U�K���)�.#ZR���Imd�>��ޡ"�������x��n������߇���$!ݢū��	��)��i���f������k�j�La�#�߻�mSS�%���rS�g����\7�����G_~	���/���������o-a>�g��ݪ��m�s������_N�
��ؖ0�U��,�����;�;��cYx����W�������7��$P��f8��h����  �k�7~[<�7�*��_|譼�������|����K��_
���НvB��_��"�&Y�_n��5�=����0|(�xY����._4m�z�.�ه�ʌxL��(��E*i��&e�!p5�)za~��*Tr��SШE�b=�o��#����ۄ���*�iFY�s&\	��	�$��5�|U�'���ఽ��
�mK4�e2��Dc�p3�U�V��{�y�=`� r(��|�%F�����w-1�dg9Aje��L������z�n�z�U���7DM�~�l����	�`���C��"�@J� �B��2B���6@�_m���t�k�绺�u�NU�:������N{Z��CB�����a'x���嘓l�s��@e�BS����'����
z����'ܦZj��+T�<��#MY\���~�K/�@�y%/rQ�����Um�;OD�C�_wA��d��0C2F&r�|�XH���3j�Y�d��8�D��Y,�0E"����s���6�IڃɷZ5/�/�ә3�Ǭ9��J��5��HQ�ku%��CLg8'�R�n3޸�t�nV1�;;���s��:�=r,r-%}�쫞P�K[��۾<�L��X�L��Hv�}�K���_<{{sõ̻���{%,�����翿u���"aK�O�%���Hn�8��+��B�mn��2r�!��׀|V~Z���`��ʳ[Y�ř�Í"܎Qdm�kY�
ZE���ճ��㡲0�ܴ�@�Ɛ̰�O2�t�h��3㣩4�6FiG��H����t�(W�8S���$�E'�cζ'si6�R2���;h\�Kri�r�k����I�C��Dg�ѦV�#����ǉ*#��d��f��nH"[�W�(얫��S���";i�K�6_�Σ��$��4/�p�DT#f���&͛�d����/���T[�Bt2��8�٪D�ܓHX�s����:�Q��k�{�P�-���� �׃Lr0���
zwa���&k�2<7���x����������E�3���8��ڗ�/n�zg�P�S��Oht���ނ~6'sI=�A�A���=;��%�>�p�3g�ۈ����g׏��?��~���B��ӏ������?��߿�~�sN���Eu}xj7�]��9rm{Xw^�wmZ�+���{�?��)��� z����������䣟�����g?����/�'_��}��?���7�p��	�{	������}��o��o������5���ξ���|�7~�/~���_��������'�ǿ�ݳ�C���%~��[��?|��]���N��	\;�� p ��`7쳸� ����v�N ��-��G�[���#�*�JC_|�î/hR���W9��o|��'��>�c躌������|���-ׄ�? �?0�
�R����s����>���a#|}����6I���V�f, ����9@�`��#��>b	L+s���f�#Lku�|^��'t�|*��M�}n� �8��s?.����E|���q
���	��~�7������7��n:�����!����k\>|W����Ish��%/W��Z��+9�Jo��Co��j���p���3��H��xqn?���i�a�?���e0��Wޙ׾��w?,�ͻ^-�T��p�=��[_����Amsv�sF#k���h��P�2��к�Y�e`8����(°J",��X�BH�Ei�$)��i�Q�5�_/����`�~L�θkn��kX��#��Wh��|1�l��5��_�*��W~��K��\�����&^_��Yݱ�ɭm+������JI)�%�J./%9Q�J�����ϭ��ߜ�S�����u{_҈�8Ђ7��z�ߞٔ�%<�F�\O�ޛ������ӇW/���D��+>!yߪ-v.�#e:�=Q2.U��6�8��^��{ȝ��M�~غ����l*��ܛ߼�Qڦ���~��S�x�/rTjl;��Yu�aۓ������#�n��Qv�:\�D�q���@w۩��m�����4�	���������$�e��+w	��$�>�9�:D�r�Ez�]�azX\��nۿ�VbRY�J�9%)�D�J*KB!/��T`}	d7mR*��xr��{��z}FL��d�͸ל^�0ܰ�<ц�p�[	F��펾�3-y����ן�{�{l*�[,�����vXb�H�RɈMsy�0=����M�rJ�*��&$��m��cM�˚�Z z�ü���I.�)�;o���v�x\tu���z��v��)莛��g�����kNX=�W[BXv�c����9-~}��9_���m�����^n{�xc��xo9�#�f�5g�d�G�4�Ѩ�xm�k���U��	g%�ë����{�[L	q�;�T.�lC^_ȗRٸ���7k��0-m�}J���Ŧ=������U��j�L��6)�?���7��r�z��Cغ9���6����O�x�a�͞�\y���6RԊM�����f�CZ6��ж�}��z�S@���Sj�N���b��N�'�rک3�h��n�<����D��
������w]�8�a�� �������w_�(�b�������rx��q|���������	�WO4{��qy4���u}�AIz�- (J!�'�)?;X��жGw����g���w��S-�MQ���! ��P�?���?
�?��ms��	�� �?��S�?F���O�'��u���fNi�Nh(M�(M�5��pCg�2�f�&M��k5�"uEL¼r����0�����"N������US� ���y\���Nɺ�e$IQ{�4.:E��¬b�C<cM2(;�u�bf�T/!4������؅���sR�Y����!݀J��.��!�vӈJ�#���3|�ҥfcA.��iA�
�HK2���"�t��"Q|'iv�E�
�x�y�����8uA�a�Q��q0��`������qp� x ��e��a����H��N��{K�N]/!��P�����_ Q3@�5�PԌS��`���}��_V���� ���-����1��'���S���y`8B������A�>�_��Ӭu��'�Yw��49L��	��i�}���w(���'�(O�|yZf��V�Ϻ2S#mWr+��.�)@����r�������t��l�Q��U=��9?"x��[ |�>�ɨK�܉B\��]��n����qn|���W��:/�gN�P�Z{�X���A)O�S!�)
�&)��~�,�웍F̺���z��w�^��\KӘyRh|�W�>܍�,�t�2��uFD�S%��L��3Cd8o�M.;k)�~�4h�qf��j�T��؋��o"�J����O V��5���@���_�C����4�?�����X
����`�������k����A�(��C���l�/�����?��6 ��j��?N��?iR���(F���o��)������4�@XĢq��t�Fa�i�(i�^[a� �?�!����'��?�xZ*̪�LĊ��r�5�d�I1��
��0�������#%?�&��"ըҗ�a¸=�SK�q	��f�Vl�L���I�͸6�η�Xp���cfQ�>bM�=Ek�A���"�?��q:;���a��^����?N���?p
B������ ����@� �=����@���_���8N��;��d�����������V�»b�0
Sӭ�Ρ�^�Y���'����!?[b�:[?�-�-�<_�W������8.�4R� 1��E�iW�m����``z{Z��d-��DqT��n�H�Ǭ�R���M�]˴99B!�݁�^?�e�(�7q�óp��Z�a|�]�5n^���$����9w�í��)��%�[\�/�(.'råm@�b"׬b�_K��Z�����3�Df��()��4o�˝�ֺ�h�I��ה�n4�'��@h���Y�4�=%b?�f=���*�T�����(&�bM� �ԍ�e���ÉG�\i�B���������o"���q:+���a��_����?N���?��B����������0��r������V��1�&��� ���/�ó� �A��#�
Á���� ��\�?�F��E���u�7��Ầ�5C-�$jC�f����n薎��(��Sc!M�Y��4���D��#����{��� ����d�)II�b��ņ�aR\k�U�Zd��c�<3���)��%�\��ډZR�|D/w'[��A��T����'j\��t�&A����]�
�U��%�o���YoS�KM�-���������&�|���?�Ɓ�/<G�_�\F�=��qG@��0��^Ń��'�s���1p�)������@�����������'B`��uru�� ��?5�c���#����v'�����ݳ����!����"���j�F�F��cb��b��Y����n�,�XV��X�5Q0Q�X�����z�����)$kVgְ"���*H}jZ��Ǳa�c��_�jj�Ȩ�n��hB�{�>�kl6����E:�H|�m�s�B�:��U�������C�עSD�$/	ψ�Z����VhiY0��h�a���=�/��?����`;���/{���$��x"����.��b"�J�7�y��?������_��^���sb��V��XKTD._�E�e�@���[��pȭ��thE�1�����"�[&���Ϊ���zQUƕ��EU����v�nq-WVqf�E��97WE��U��Ѽs3��Lm�sj�2�\l��J�:ż�U]i��M�ܾX)M��.;�u;5[q#��,�h�R"��^�Q�&�:��@[Y�ogm�3���ʢ�����ʢ�}�zi�"F$tw��l2���u�����Why�\tq[�[��>�̨�lT
F[.S��t�<5�'RG�QB�U��I�9��]�P�t��l��[�/cDB�A"9��\��Yw�zE�9q��MΪ˴y�LF�U�����&/��\OoF�Z�Z�+���TZ�["wI�Ir��;�����*@�̉��5y�jӂ6�PuA�Qh�����8Ru\��sJ�&f3nlN��3΂�yi���a�JG�M�BK3�i�2�Ȗ:�\���H������'���v'��_��
�������?p��@(����/�������6�_�q�f�Ë�H1!�d�����>y����,4��-ۀ�c�ց`�t#��Ŷ��EN[gM�a��|��A@[B����޳�Hr]e;�z�nl��
YOb�܉=�;;S]]Տ��Տ��~���2�����]]USU�\-2 EHA�!�D">,�_���|@dK	�(B!�{��=Ϟ�zv��VS}﹏:��sO�s���x[0��Hc�$��~)jf�� �W�d&e�?t��v*�g�-?r>���z,�P�A��$I���jMϧ��Y�A��B�~��s��{�s�q�j{P�U��T7R�Y��V����bǌ�6M5�w���>����x�{`�{�|��h�����R2<2ƽ����?���}��g�祤���9�A���|����B�S���w�����@�����������[r�������|����G�@�_���$����������p�?��.����N�1����)����/%9����;���W��?���u��%��t���~�����@��ݣ��_x|^�HS�&٤��D��{�{��I���'�z=࡜[ >�t���w�������>�t��?��~����x�_�KQJ��Z*��c������nV���N<��P�v��䚞4KE�C�?�[�`�&�&=�C"Q�J�����G� R����nKm��
ٸ�!�J>�M�y�9p���hZ������T
d�)+��Z��3����.�?T�'�����>�"Q�U�Λ- >�G���k*ޔ��E�Ќ[�nȪ���U�˫s����} �.�c4�_ vgKZTQ@k��>!��\ o5���8ڙ� v�>!2��gM�w�§M�n�!���Z�@�-����H��__q�wKvۦ��� ��e�t��
\�&�3�6,�Y;�۸�g(.�J�.�B�&�JK3�W�n�ۅ߱Aߜ�!�v����gݠ[����oϟl C<艦U�%\'t;����*P�9��[��w�~�.�	RK�W�^P��ߎ���;�(i�1���YT`w4�1-�z<�J����gf�QW�Q����ܵ����Y������XH�Bp@����pWR���	R�LT��o�&^EuJ�������Z�-{�>���e�&U]�ڵ���Q�ƅ�i=���C�)���\F:��O���8��{��s��2����g/���q������)���.#�W]\�wT�hF�k0��L�9i�F��%��W]*?Yg7@� W�b+7�[�}�҃ P;�֯�4�4�������V����³z�պL� ��;PC�ߓ|J� ��թ]k�R��"}��?M�������������ƕ����W��1�����|�N6=~7�n�0��{<Y�R���Oyu//R{�����M$��I~R�J�i�����]����sO�����l3�{����ʯ������/�����r�n�_�?w�������� LB������?>��}��籯?�T�����
�P����� nKG�l{�77�}s`�c���J�A�$�A
m���6S^�O�0s�>�����߹@���r�@��C��0Q'<�T��ꍶ�D,4̳��/G��zn��V�[&���6(v��0,5ك>hG�l�2.Q�|����sv�{<�T�/�d�k�.tV#l��wz�0�\@�&�Dlh��0�,$����l5��q����޻)��FC=���T$7�R�5ZnJNJt���� �Z��Jq)M��:Ś��2����q<_
�{^/gdt"����a�	Z�4���+�'��;��U<�طΔ��0��ܩ62��L`&a�B�d�78�t�T���M�i@�|ɺ�DH��XN�Q��ɸ�|Z�[��zMh'4bh&H�_ߦ�A�Xb)�򫝁�4��B��|�-t<�RJa��O���q/�#s��U� H��h����"�H�C�K�S�
�HV��&�5�ۯ0a�0X�G��W�ȕZ"��3�h�Ȧ��#��Y='4z��H��B3�M��z*Qie%��2�v��d���K,�{D,��eߓ�.�G��֪	߁`p���TG r��X"K�A���������иΓ�.E����r�r�k����rŚ>j�n�;�0Y%Y2+
MFʙ&��ɤ/[b�9B,���`O$��A3a_eH�|c6d��xR-��^�w/�
t$�M��&�ѸY)zb:5�A�KGe?Y�fk�A������Ph�!F���?�X����tbi�@,1*>���7�Ų?���Tj�IK���-��/��s��2��3"��h�E+5nԚ|�#P�W:T
h)���%�J�J|e���W�@��fܹ|MȒG����Ēoޱ/ �yC&��!����T�r'ć�����$�$\�%��;�q���f���R���6=nE�_�����NWz��i��rt6Ggst��t��+:l�tQ��![�ab[��kc�v�}d���'�O.~J�+�`����p�م:�ؓ�u�^�*'�su��"�d���r�i={{<����%�d��dM�h�,��g���S� ���(�$s��LhbSȉ�eȶG����z"sD�왅�.b���)���ڣ��c�vm����w��o���_�5G�u�ɵO``�{��9�M�TPфN�W�=r�����|:ڛ�m3�X����I�`�y\ct�b��/c�ǐa�6�b��6H�
-�� �2�® CFQ�����gr���s�|������Oֱ_�۞�Q�|��Q�ΙK�����౤ʆ�v������������#�I���99�Z�99�C�"�ɢa:*��<HW���U86S4�E��
ؚ��"2h���K�S�.��BDo�m+�a��4�Q^��SٽH��o�:�qHM��0�p{��
^)��2$�j�Z�JP�M��iS��ڕq��dh���~@r ����&1f�A)����l̘�M2��=�f��G�)Y1F�B1�7���Mw[M�ɬ\d��x/`}9�T:8����_{U�ji�I�p�B�m�ƥ��x82�ToOr��T[�>ˑF�� �m���1��"���lV��H��.�9�p��=�}WKz	�T*?��\^C��T1Y�1әV�A�5�M�9��B�'�k�
wuޙ��9S������3��_���ay.E�r,i�,i�."��ߩFi��a!���^~8B@H*�[����bI*�N��mF�E�%���&.j��
L�"��Z���z?�xW�l�]=he�D+��Q0��0d�ʘ�����l�@�QD0�*�jn. �DM�D'lr��hZ�����f��K�Xy�r��k�k	���
����2_�V�>��qt���S�ER�>�N>�U$1��Z�'*��Ұ�U2&-j�rmu�l�䆅����E$�������'2�[�}�!�n@m�h���b����ܮ�ҩG���a9��0�Ǎ9Υ�x�-~+)e�s+eK5V0}�d�[�̶����va��c�ْU)o=����p�azj|}j�dC4MфX{
<1��tۡ�s����QF�4�
�.�ak�J>�x��{m\	+/���!��x{{h���yd���w��{�������o��/������O_î��xUw�w������?�����;%��:���83��:����N��$��������7���|�O�旱����x��z�����o�������~?�� �� ~����Hޯ��+z��-^V���]�q�����J��O�����W��k��3��~ā8�8�B;���>\�����v:��N��&��v:^�݋������v:������lBh��-/1��9�*W	���!dzX�M�]��>s\@��=�g��{:�1���?��e샅Є�0'��Q�8Ǖ�R�8�9�oq���@��e3̕��ٜ�i9{fk��g���lp��8��0�%왹�~�l����97����U�6?���{�y��K�ZM�9�O��lk��3;��BH���$���G��y����H�M���� ����{*�z�TzF��gZr/A�@�0xv��pM�\7^EM����G��Yx�a���ߋC$�pY��uPdt�=>�b��g��.j�:mC�[<G�@��Ws�-���g�]��fH�23�D<I�#;p��
EU�bG���|���'.�:��p��y�a������b�njMk�"j�!#�Q�g-�k6<�֋ c����<ϻ� ���o�F��B,],�e&�cR�x$��sx(�
��t
�bq&UŹx*|!�`?�PG��0)6l��Eqi��L]�,�WS�/���AW��hteͨ	�@�(rW�&W8}/��&�ډ�l�U N�%+�fX��D�7!M�2����P�~�ʚ�bI�D����[ZWDw|,O��]���jOD� Q�Z��@�� ��	ʰY��^A,T��اיM���P�t��v	S�z���&�-�i���eҳ5|Kn,�b�Ŝ�8��Ā�Sn�����CWf�fr*�!���8�Y��I�=���$�J�9[����|�p��[��	�fwE������|��E����.r�nmZ�����+x�WL6(7�I�7�׏����F�>���BfQ�.��[o��Dg���!J���[6F5u��V0!J�q�$Y��Y�oJ Ԟ���+����"�tǴ�`g���i���|�w&�����<�f �'��E�'�����9 n��~��ܠ�o��w�ۼ:��������<��팡A� �A�l�o��	NP{S���z�D �؅N��f�W�����CU[�(w�d���<�"�
�a����Cӫ��>�T��:��q{�b��mD!޶�31%u���0��%ؚ�`
y�������Yff"���̷����?���9qd��̯PL��c$�7+.clc��obB#������ʪ���v����0-���*��,���x7������� Ը�$�Xt��b�E���+����S���J�nu�E��䟓E �b���@����}�&'��o`S���������1�)�����m�<@�����&���Ao�_v�cz ��CÝ�B����|^��N��Y����	/��X��C�|�����Ku.: ����/��<-o$��l6B���b=��s`>�t=�G�x~�E-$����O�6vK�^+�Kz� B��J�W0��J���*��z��sr<u����0��� ���o=D��s�$��W�� |k%��������k�~����0��:�_K����(������W�
$�
�B�G��*Ss�����`�+�@��KO��Y>�L�hw�C�����em�Sܤ��vJ��ց�nOU�OO��	�}0~���T(�>����g��8N]��-8cd[�	q�����������@����:�K��.��P���Mu�7�������.F���,�8��y�$,>Tt�����z����;/�?~�d�ם��y����u�-�Ԕ�IF /8}j���-�"���o�3�Lm�����"�1ζfX�U����,,�(�D�ʉ=	�M�Z~o��8:��W���9wƝ��U��?��s.ڠ��E�}���~��[�ig�1�\�1M���"i�/!�4�n>+�t�
i���a�V<��A��`�K�~}��z����@P����"*@���Q�x9^��
�����`�F%�
�(�S=qkiL��!/�}�NX�H�S�a�2#tG�J�Y�e�������,�w����奜������� ������_��=0�h�*��D��S{����7�J>�[���R͐'S{�|+M-ܴ��ҧH��	�Px���VD(���+U�Eo�t߽�iHY���c�t��G�j���$�B�.���64Z,0���QX���&HY�
��;��p���.��ĝ@K�@B�f��!>_�O.�:���q;�=A��p��C�@���v�'��v�v�\3��s��J�hX&�Y`M���T��}���y3ƴ�?�59�d�vJ���Vw9(&%(|��u�^�đ�fM!�X`ut�<���40���rr �=�ES�����G�N��gw�75��r��G4���w��{��*&��$�	�Z�]p���85�PF�q�PV=��ƉE�V�����Ռ�������\��U2՘#��� �q����U�M�#��EC4�O|u�nG�X�
q�~�"��%� �~�4MP.�L���������D�F��H�i<e�����=�f��!@!	1��o�����@�dߩ��A���p�*.��n���?=*^�-ime�ԓ'��&b����S�#���5�\�聼��4�yl�Bh�/�Z��A���PZE "{8{���DWR|	"���%���4�=x��\�&-;|���Ba�jE�o�Z��rh4����0AzIO()��:�`�"�	?2X�?��'"�$�O��9�"{���JsZa!wa}0oZ��,��� ���`k����Ψ�C>�x7"yE>t	����K��'ĳ-�	�B�P����V��.�jT"3�(L��Fk�$�FO�9��R\.�����m��PE����g*�g�0����f,/�;HJ3)�5�Nb�j"��2�����T�c�'��޾gJ�P��^�u�WT��|�N�D��J1{W ���0���.�[X�Cr��t'�d�"#K��3^��t!��:�Z�_��p��(H!��A2��3 ~�Z���:�$��_��u/l��+Ԥ���1���>.�E0�U���J& �nd��	�OZs���`���$b���2=I��!�֝�a��1c��Ԇ��OɂyDˏ�4���g�#����k�}$y�A~�|>I�� �	��vV>)$}%�� o��Gn2O.���=}|#�'e�t0���$������O?�?$�h�a�r�l��\h�KT���G�-�"&{ ✺�h��h$C�b9�*}(�c'���!��1���a6pA��۠�ѐ��1*�ᰶ7`��2SO��g@,i�n�|Йp�ą��,䏣����:)�4��U�~�w���������CJ�`��'<g��p��o�ǯ�.$�K��d�]�O�R�:��v�>�8q0���hy+9
��uHL����Q8<�&Ʀ���iH�LԻ�}�+�������y�ĵ���4 uǦ��f����!������ι�����!����xm�S2_�t�0�v�*Rp�Ǝ#p'�q�}2��E��'�ʕ�\�8��Ȝ#����z���G��j%{(C��0�1��H)<�mk4��;8"�ȭ�(Jx��+� ��XaWCc_6�8*�'d��d\x�/P :$��8�e'>�Y!�i��"�V�iV��>�)�֡
�۟�pl���m2E�´�f�)�b�;dmL�ͫ;� �;.��)�	��qԄ%E�����L��!�zVʱ������Ԭa�~�B��;I
�Q˼r���S��O�¿�����:�\R(b��J�\F���=���RB��"Rn&�,r�?5e���i�U[���������l�Q׾���j�7�P�#Y�B�wj�'�"'f���O܉GnƂ�9�$W�!�e>B�>�+K}�E�R��n9�X�CX��������W�i1����+U�1kۤ��{�?��B�3��q�8�~�E�`ŕb�럦� <�|�'���O�y�
��Dy�K����~�f[xsB���1��NG4�@n�5�DѼ�+L�52\n G������q/z��g����wd9���stn��N��
k�="%<�A�N� ��e>�,�!� 2��,�?�2�O�|�%ː^���~Y�j�.���o�v7��Cs�~+T)s����� �Jqv���l���=)���p�T�2y�LC����5��\D#7��(��'�9�I�x��=�p�mp�ο�
��;P~ōi�hB�^˲Z+��p�F|r5GJ�HehM!͈����d�U��gk�k��N�g1��נ����� ��.rP2�-�0|4��p������@1B�f0�1cW�1��W�\�<�P#�	�Ce�N�Q�f�ݤx��w  �F�	��7�݇ݖ���r���U����5C���������hX���aɕ�]��iǅ�,y�;Ǚ^�* o������d�2gP�W�o���z0��i�غ��c<�|H|d��V��jB���5�4`}==�lk �lB�!��Tr�8��"�/�;D�g�!����x
{����W@/_�/�+��R\gեjM�*P t%�M�Z��&`z+���;�wq�q�-��R���Ā���x,�ⱨ�X_�귨��{1�;��d��K�?o���������lvM�C��/�s�p�w�/�������>^��4�Έ��q�;��2v�x=�E^�����?��������0���T2��'֨w���� ��?���_^��,�� ��/��;�������K��u�
���B.Q�w�A��ߠ�39���8`+�N��4��q@���-i1C���?�����b.��9��」����D5���iI���"�r9!'�lFI�Z��$�Ϫ�`�l^�U��� �F���y/q�P��_��ϧ�BX���b�W���J[��/�Wr��5����YGZYnU��:o͝�=�*S��ʋ��㍝nu�ZB�>6sW��|O���e��|)�|�.[�VO�����qgj��S'����JX؂0<盙���'_؃E�.���O5~�ӛ_��v��jdn���u�9�W�J%��*5)7�4*{�?=�?Z3�MO���6�!�	��,��q@���̎��f�6 ��>����/
��������grl7=� �2i1���,���W��W��W������l��' e��2�������~���[,�����6�Q����$������u��lE�/D�����o�����C7���O{z�7;j�O����)�[����ܻ�7�����#�Q�k�DTD���l$j3~~�,?7+U��)�Vj
��by�|Жך����,�n;�y�i^4g�*Iaԫ�q��z>��мo^��j2�wT�	���L�bt|�Oǚx���O��YW@z}Ѭf�������ZN`Eni�jy���`�<*�+���<��p�~.��R%�U�{�=�@@X�j5ID�&��e�4C��7�/7ey֘a$�rkV��ظ~^8��zWL��3{�j'δ��l^>n]�[�lev3�e�����T.f��B������!�RC~P���U��KO�w�85��
��lp$���$Ӗ���aaa��[������ԗ/��ָ����vB����IO���~���r�����������Y��%������m�����?,��	6��Y�;`+�V����?�������l���������	,��2`������B���?6q�v��v��L�oZ���?6��YC�u�YA��]I)��j7-e�5��IJ7��n.��E��J�dt5!��\��guv��O�-����?6�8���8�^.�NZ���w�*�ӑs��Vڥ��,>k�T{�,�מ�1�w���m�!swX]��O��H7����k��qj�ԫ��?Lwr���mb!�Ag �ҏrinL�]�+݌��|:�+�;�㭰�����9�����?�X�����6�v���`���m�؂����� ��?l��������?��������.`������A���?6�����,�!؊�����1���?�����A����I��%�y�0�dŅ������'�����U�Y�u	�?Tg��S�it���6K��iY����Y��ȏ������m�_ɍ�sY��\��Y�s���\M�/r3U?�N�C��Q.�:�îa�G5�OXf����E�P���ǳ�g8�o�!l�B�]Rd8��w�$�����R�Ժ<�[��C�3�"�$7ЬW�~�\��獙ڻ/L�y��P�&��T�Z7K����y�ܘW�C@hz�u�R����<<l�O:�cyp}�7\�	�W��&'�ri:o������m����W��\���Z���6���n�5�i^�5~PΤ�	u���]?~�x?�����?6q������l�o�?;�cs�)�ϊ��[����ƀ��Y����?n>�=����0�������l��������gn��C����K���������\��?1�����b�w��z^ɪiM�5/
]�Ȩ�|N3�����tAӵ���|!#d��W|��!W�f%���������E��!��������|�Z~||<m���wW�J+&?L�;]�=���[��󺙭�=�C��m�7�N�rM[��Դ��ӽ��fw�7bJ��;m8;O͆�t��_����y��z��a�н<�]�������L����o�^���vP��x}�O�,���W�����?-"s��l��/d#��a�����o��o+!��A������/�|P�gsL��1��E��}b���?����B������X`���}b���?�����i!"�����ۢ�9>W��1�-���(Y-�HI�D�׵L� *���s|&�iZ7�M2�nW5�B�`�P�6�K����+����+�g��q��ڷU�7n��ci~��h��P�[�Yi�j�M�#��M��/s-5j�]h�%�pq�4J�paWr'�ji0<|�<+{塣�ϭ������i#��g���μ�=1b���b��"�2wG���H�s�~��nIX�؜�f�31����j����:�JF%r�+=D��[�M|,�{����ǅ�����/N���㱵�_�L�����W���� ^9��?[����Od����R:���n�-���K����cA�ǣ�]��n���~޽��1���׊6ht��w�N�i��K;X����x��f_��*�w��U�RD��� Z+7�R��?_��8c��*k*�9E��)�f#gч�#�X+��Y��E���ټv'.��J���#����Ӣ�U�j3־�Vagz���A�2~7Q��̊�+��X��)9���޸������4���4�el����1bjU�{�{��Ĉ�����К���$?��L�0ߎ���E�*z�*_Y�����ߗ?����&�KO#SV)��|�]��<�}���W3�B%�Y�]�>����7H$#t��k$H�p�vX��)����\͆m����H-_�ȭ��G9���yU���P��Uh��}�Y~�����Tjڜ�̙1�7<�!)'@d�)�XF�	��L^xx[��y:�a,Ħ�I�9��T3�.|�M%���֘�P�3���顦��A�8+fRͯ�;A�<���o�O�Y���J��?�>�I�A��WK�l���x����l��$�?�����t2��'7X���$����/�h&��������/�|�a��e%>$n���r-��=�����/G9?Zs�=k�����o�O+q`��,[xW-�r�ܦ�+��nly�y!�ޚ�ߊF�8׊�X�}H���%�iNgK|G�5�F�Fx�J��z�Ue"�6�t�W�ظJ�g�>S�Y�T�W��|]/�z��B���a��ԡ�����D��ݬ]����lgb�B^�X�����fI�z_l$����U��|��͝P�T����v��ԼW-��dk�ḷ����x�������N������	��x����_�:�WN���϶�NB�'|�񿎒ND�����N����_-���������j�'�����?J����}H�N1c�_��� ;����NB�g�������"���dӱ����*���c���������W��I��{�t�/�O
�L<K��W�t�]R��HW�t**%W�� �фK�R�wRz���hZ��U<���������R���Q���ڇۢP��n�[-r[�W���o��SQf�����!=�����g���� �(&J��t��[�\3a��M�!R�U,���N�B��HIF$���K��%c�t�cňǮ�����ػ�܌͂�?/M/�MU%3:}gj��:v��xf��� �'}��3k�KgYtFf���~�܀�?���-��M����DM��fZ�L4=s����_FQ �X��Z �V����S�!}�H���gY�Zݖhi*�[`�^����5]��Ž4�G?ă�i��n�Qc��
�G1a�q$ �A��N���+���n�o�����h�O�l��1�)����:��%of2��@Z�S��?��}$���x/`�u͔��X�c����S�U��������	�8h�,
�C�I@%3���,��XJY4a(R�C"��}�Jw��p����0�	RFR����c�YG��Q��q�|7�9w�,1��!ERP��|�q�u��0�3����������B�8�^��	���"��5����y��F��0<?�5�(�C$ZR���g!�!�j�d,yƈ>���}{ጷj	�*]UU�B�EF�c28��
��� +l/�z�v��5�����kAQV�߲\��WZ��ԛ�s\��X�[b�,�T��F��޲Un#X�o�u�P�X����俍�����5�Un�1��-V�>�aO���f�fM�(������6�L,�J�a�;��
Yo�o�A��walrU�*(���bH�O7m�6KY�$�@ј����,�nG�r�Vl\���3����Q	�p�.0$1h���A�q/�_��3͸��a�/Y�t+2�t�ELC�ek4�� }�yi�2��pE�b��~"�2��%�%�y\|�J/E��V뙤�R���Rd
�ː,,�Dm"���r��ݥ>m0?9�����1���D&�]
@� ͵	�	8SC�6�X#-䐣�/mT�  a�����%+򣄊����T�hTQ-���d�A��&���SﮒY��
�q�!Y;��dO��͗�J=�(�]�3�o��V��6ڭ�wظ|���{�R/um_`s��2�:��umi��mDZ�٨�[�U~ /�ݻ�T0"�D��v0mz�0)�dA���}��,@��x�����%!N< x�oԋ�R�i���7nGħh���f����c@nj�����>�fd0�,Wg����Zh��X�U��׏�CW��rY�!�^�˥�F؁�Yd;H��h���0皒e�Ol���xؼ/=����#q!Xg�XjA�da-��
D �0xa$�F�vH��=�8����}��@�-���Z��Mx������@�(�rY���[�v�������vd��|��/rN��/��BK�w��e��a�v�$�'a��df<��� cˤ�����&����e�E]n1ݟ-��)m֏f����_eGZ՗tI�]��\��񃅺�hƘ�A7���"��������i�:!Z2��%]"��۬*c��*�`�"��'�7�"�&��Dn,h�@�j�ةj���&�zUM�&�}�&\����:������K
;�O���E����X"���O��GI��(���%��RMT�h"O]��ɹD��F��Qt�Μ����6������&�֒MDVɥQ�-l2a�Ȃ
�����Bc����	P@�_/ @�F;�ȳٌHci�F̌T+y�γ�8^�%ڪ"�&�������P@�A3a���!A��Ђ�!cu�Lm`�C�h��irob-���<� FLP�ã
�@T�K��S�U�}b8���*,���z�Ҫ4�𫈘z�T�K$�hI�>��h��GR�a�%i�	ؔ%ZS�Dy ��5u8[5�p+]pc��3jB��"�e˖����E(*���N�B�)J�,4�������N�B@�$/���̥�&~N2,�f�7����0���<7A��H��� ��EV�8k��9@N1PE&tXK�p��G��+�pHPە%�J�����')`w��Z�纡�0�4��4��[,ߺ@�A>�� ��<*����"��#x?�6��Tn��H44��S �B�Gy0��m#��i.sL�~���"0�9�A�N���.�>��r�`zlmM[d�55t�����US�˭yq��u�s̕xS���F��f'�W�1�DD"�F��EuG ��{G���'���J�ܞ����Vn�lRsF�C�s.���Y�4�=�X�t��Ӑ��OΝ���L

��Yf�f9<�}"�q���/X L��������@{p_8S�lA�Oy��OScj�Mh������mi<��?L+�/lD<`kqZ���P.�r�-��)>J(��r=�4�0X	@Ba<a,E�	�����?C�~)�i1`�%\O�_�!S/k�v��CoE6�c�ţ	Z�y��1����l���6�H�ѹ]��삔�'�U4�z~N�]��?<��"�`���tfצ4��5�U��>QI�qX� I5�	� c�P�-A�t3w������P� �1?遢�`L�� �cԮ�X�i�j7�"���X�&��\=��o���o(��=�V��LAK���5#���/��e_>y����ry����m�NQ�[z9����@La�孑��7���X���^³��.�31	C��1;�퀊����,�/������pG}È�Le���=��N}/�EI��ݒ��
��/A�� M$��TSX҃˃6��[�N���Ʌ�r�P6�?w���o/-c�����048E��5�,��ϳ<�X���m�v�kI��9�cS�$�<��p�r�13���J�[��)�b��FN%�
~�@�=�YP^����������?��l�2ݛEg�ly�sbH�.��ӝ�Ō���伶c���A�?���"ɥ���u����$V��Q��s���_���Fz�9��7�}�-�f1���=��z�*6�w�ؤ)�QX��2%p�lI41�ˀn�f�_h
';���}�?K��1|��7�\��3����8êH����Ϗ&�S��W�,�{���`��<Y��h67&*^�)R�7h�әM���e� �8�0#�=$�A��'A��p=L�������x2�?%�T��.�o�AB�EK����F��7g�M�Z/ٻ���Hǥ�9�Q�����B"80/(����7���0��%	�?��c��?��D<��c����]j��17��&�����ߡ��e�)4�������4֦�sF.�MuK��c6�#�S�ܬp��ú��u��lh�������&��q�D*���"	��6Ɂ��`X�; ;�?O����Dp��(�����:�1}{eUՁ�U�5���-��1��w&2��D48�\p}�~��M�������n�ȁ�E2���.�>^�!=�1|�3�I �U[A���5�F���@�v2�w	BÜH�X�a����õ������a u2�I��$�4��7?�'�,�m̥�ɢ�c#�c���}�'�L��ÿ:�t��wV��մ�nM�K������?�Lp��(���!F/��>f��/ ���������a}O;J,���m�{�r%�	uh��ovh�16��G�X��^�X�_�78)��¿�"B�'F��MZ�����ˆ��~��ȟ^=V���ϼڕ�.ݢ�`��:��s�>�ݶPTQ:���p?�����}��]����#�?�/���e��'��_<��q�t��ߊ�)ۏ����e�����n�����otu�7�J��t����'��~���2�Z�O�f ��Mg+&J�I��U�]h;��ڗ˼�����?�������`��(�T����?Ǒ[v`� o���|��l�[���6{�柗8�5s�E�~�Sliu幜!�aRdA1`m���{���M��&ӫ�	�%���X����1����ᨥ�aZD�Q�+�K|b�5��c9��%A����5գۛE.��4Ȏ]�<�o�{������#��`���L��(�-6�	��%L¦	;B��O�Y{ܼ�tY�&nصgF��B�������l��UZ��� \�Z��`��]��
����um���<w7�{-�Vd�~1�K���ޚJ�_��gy�f��V�g��~_�i`:d��E����a���_���t`�%�������1b��}���A��bG�po"+}D��O�f���ywÝ�f#l���"Z�^��P�w�˦<���̂-�b��*m,�xY���b��������j,=�Lc;�ht��o�X*��]]�#�]�n����l�LI6��."r�����mPD�|xl���|{��̌����c{lKHy@��ЪR(P���Di"�R�"*H�*�< �	)R�ؾ��cw��d�	��ý�9�9�̙����8��\����~*�Ջ^��q���]�>y�a��u~�����������(z!��������� G.zz��!<X�ȉ៝0r�y�vU��H�l��D�c����XgV���}�:�H��������M��CϐH ��dH|�����ȴ{���w:�uV�%����J&tɟ����#�R��K]�T`O3�J��6���$�IkI�`m"ljJN?�ҍ5zJ��t�m��Jy�e��Coˬ��F�q
�$�,A���4��*2��n0^u��`M��,�[�bv[W$���6�n�JONXmq crП���J��~q����������oO�XoC�B������]��I��F(���dz�N�Z���m,�m�+���9���l5�=w�O������Y�k&-Hy�V2��]'�\u��)lG���v�޺
�����J��p����l����/��� ^G��y��X�?yo�?���r��!�c�G�^��#��7O�U}�������#{WY�O�y�&ڝ6A�N�N�M�j�	,g����x'q�P�Etl�";��6I��|~z"�n~������g���/?���~��/�������_�߸��eh�)\����2�@��נ'�c��������ؗt���x�M���0tC^��-���%��.or�s�X;�z�ۅ��t���?��8|�q9�{R{�D!���'�W�:�1���6/mZ8π�����o��_����oO}��˯���/����ܜ/�
_�<whN�c���w���r��y��(���c���Ȣ�	�ϒ�_���v���ɗ�������?��g�����~�?~��;��ǟz���h����B�U�7Uh��Υ����WS����j+��k��I�ĭ�� �m[x�(��6�1s3k:�,��-����%s6�0Բ�\w�X��ۤ�H�s���/�ë�6����_~�s��o_���o���;�[��-��VX"����p)���o����Wn��Ƴ����_}~�����V~�ʑs��#�9�\�e���C� .S�-K�1�Gr�����2��vL�F�Z奏�	ml3l@���R]��4a�.�D�5-iI�{����^��:;/�@]��
�%u�A��85�����sN�5A��\a�Z��V�۵�TԒ	�#4�Q\��5A��S^J9|��2U��T	bӢ�h�ȱqES��"$�>M	��#So��12V(q��s��b�)Tf[C'|�Y�%�({}sW�g
2�w�������6��-�"tw"*!8j�>k������ )��xC���K�@S�m��������$O��B���`Q��wy���t��3���8,��עF����G���B�M��fb���b�Ω�Z��d�e} R��~�c�e��h�;�7VD�@�N��� ���޺AW�(���f5�X#�!���:�ٲ�ow��<Q��3�P*���>� ���zC��ʀ���c�8_5h�����º:wK1eb��e�J*T�r�H�_	�,]�;��c\>l�c t�:�XQψ;���C�%*��ʋ�s�O���gHe�R%�k����}���KV@~�q\�9�o�V<yX�S~��5��W<����|�3�tc��k%�*�\�W:���m�+I�H�0@A<�H�^��}kB���W��<��Dn����jEܝ䆽��̴��2[Tz���Ei_�)U�ʫ�ή��, #e
��#�R'!u�2�bQ\NE	�Z��8�PP��p��f�ZF�V��.Ǣ!P&8I|�vs@;�>c�4@\ �*]Sn?S\��B�	43.FS�5�y��5[U��k����{�r4�őd�����]��4�Q�`ժ:���,�g�\>����Wfa��r*����E��2�dh�� Z.rX�gg$Q[��։i���a�ը)��Lt8o3�o6��O�U����!��jk��@�0fb_Тf��Vot ^RԀ<�7N1�	�c��d��8�9�%rY���S���(�� S�(Y�:� ]1�b�i�DX�s��Rc��y9T�--�;u�,׺s�3��{?f�{�L}��	���}-�5�,ʹa���-��;]�.O f��R=�E��9��(��:M�b��kK�$�:|��)-3)[���a�P�����`(��%�,�����l<b}>j
k��
�����ƨb�Y����5��l�6����Ra�ZT�CGV�J���WZ�������D)L�b/fc�m�2a�CM�͈.`�iM��=�Z�>׉�\��YvcN��0�Z��JZ�f�?T��ۙa5G��9ԇ���#�U��4�!H�֫f�Y�Č�����S
��PwS�M��"��#�j1y� �E �|"�PҊO�b\�xج�Ga�:2�o�M��/g�f��uo*c�a��z0Q	��#� �@ٵؐ�qb̉2l{�\[�q<�/�9���3��/ء5B��
�Jbc�df|�o�Ȳ0���Hvl?o�Cf֚qK$���GX���'���+�_��ݸ�{�֕�i����&�_I�_�yl�Z�n���;�C����	�Ǐ�p��C�z�N|��ur�)�����'��ӻ_��6�_��:��׷�g����^��RE�:J<�\}Pd��"��^>��~��f�{�1�O�C�2��4)������B@���ji3h�&��#�^�(�kH�XǺJG�z�8^�Le�U���0�)T(^�����H~�;�)�� �}�c�1h���\-UZ>� =�Zc�)�;Q/X���Rb�����f5Y�!ci��4c��R�5�(썕�Z2�a}�]�n�m�^���vQ�6b�H�^
����
�2�CV��wK��@r�
rz�P�z�}Q�g��ZŞ"�����;R����V]3�j�	�u�l��&�(��V�O5c&T�N�t�An�bL;è�>S�e���xTT�fa�%�UM?��Y��T�R՘�Af8�*�G�Ҩ--t���E��8�9���d�z��*��-;i�GF;Du�l�Qa�A؜�Fx1�@�<!.Q�L��<i5����s)P�J u�$WX��B>K5���gQ�-�g*{P����E��f�g6[�ӛ��A߳��S;��;c9y㡎������(�����"m�������o�Zk�7n�z�ڭc��8bj������L�'a~��hdZ�=L(����n�[q (n;!����Zv�xr�*��
g̏�
�N`�(�@G���|��'M]J���x��-��h $��t���h��z�o��b^H��A!���!h�L�'����@�V�N�Ԙ����= �G���`����t���_����4��[��}�J�}`��g ��%���tX{����Q@M�!��%����eˮ�!��;��4j"���q+����nW��!=�H;{��90I,wA��������\�Jz��&^a=��F_�æI���W�K��ۧ�H,d�ʐ؟K�a���275�^ͪ�Db�ξ;/�7^��3�%v��%���⸚�C�լ��4h�6��@�$�K�ۃ	���Y2�B!�΀�t}��X�\ka��b_ϔ�\�0;�sAŒ���Oā��a+��^����)�3�g���\jx^~��	����,���'zD�dJq�9sIPN�M6�w��'��&"=h��,)��H��7�.R���V��-��j�кAZ��ab�ճ$�]QƭEc<x���@��1��	�70���/�\�s�����:��:��:���u��h���ѪY��b��b�����_<�K)���#���ִ�̠�v�`������?��8g�FThk�HDy�)�s$Z�|&�GT�q�M�U��}DS�S���X�
�|��UG��V��E{�L��0�,>�ՆO�wA�b���:�@*�_ER�(�$�BO�yP���E�����Y.�z�Q#�N��'��QV��^kD<v�����ȆH�ٞ���=���M0�`�A�-fH_mi�_�L)2��r�T�Ȇ�A��hdL�J9:H�H�l�c3>��#j,�A��q�{�2�m��E�;���#QƧ᧎F���t�<�M�a���F4��&�)9�c�ӟr�;��?	]Os�a4���ȁo�W�'���nSt�R��ڲ�t�g�k;ЍW^���+�<���V4�O݂���I�#�c�{{�	�y"�(����<�M|��`:�;��|H����/Y4���)��j�p�^�n$z8=�� !�`8��񻷡����߹$�$B5��&��C��?�Õ[p	@��1%t[}j������B��
�JM�FC�!=T"\8
F�(�`�$  P6��  