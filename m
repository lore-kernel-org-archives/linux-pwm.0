From: Michal Simek <monstr@monstr.eu>
Subject: Re: [rfc]pwm: add xilinx pwm driver
Date: Thu, 15 May 2014 13:54:52 +0200
Message-ID: <5374AB0C.7020105@monstr.eu>
References: <1400066773-14393-1-git-send-email-bart.tanghe@thomasmore.be> <4262573.aEBTd7FzV5@wuerfel> <53747FB8.2090706@thomasmore.be> <33a1dbfc-bacb-4804-a83a-9915eca3183b@BY2FFO11FD032.protection.gbl> <5374A55A.4080906@thomasmore.be>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="28E88AGEvL81Xrxa9uxRQ5ugIqRhvlnq4"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5374A55A.4080906@thomasmore.be>
Sender: linux-doc-owner@vger.kernel.org
To: Bart Tanghe <bart.tanghe@thomasmore.be>, Michal Simek <michal.simek@xilinx.com>, Arnd Bergmann <arnd@arndb.de>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, grant.likely@linaro.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--28E88AGEvL81Xrxa9uxRQ5ugIqRhvlnq4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/15/2014 01:30 PM, Bart Tanghe wrote:
>=20
>=20
> On 05/15/2014 12:33 PM, Michal Simek wrote:
>> On 05/15/2014 10:50 AM, Bart Tanghe wrote:
>>> On 05/15/2014 09:23 AM, Arnd Bergmann wrote:
>>>> On Wednesday 14 May 2014 13:26:13 Bart Tanghe wrote:
>>>>> @@ -0,0 +1,20 @@
>>>>> +Xilinx PWM controller
>>>>> +
>>>>> +Required properties:
>>>>> +- compatible: should be "xlnx,pwm-xlnx"
>>>>> +- add a clock source to the description
>>>>> +
>>>>> +Examples:
>>>>> +
>>>>> +               axi_timer_0: timer@42800000 {
>>>>> +                       clock-frequency =3D <100000000>;
>>>>> +                       clocks =3D <&clkc 15>;
>>>>> +                       compatible =3D "xlnx,xlnx-pwm";
>>>>> +                       reg =3D <0x42800000 0x10000>;
>>>>> +                       xlnx,count-width =3D <0x20>;
>>>>> +                       xlnx,gen0-assert =3D <0x1>;
>>>>> +                       xlnx,gen1-assert =3D <0x1>;
>>>>> +                       xlnx,one-timer-only =3D <0x0>;
>>>>> +                       xlnx,trig0-assert =3D <0x1>;
>>>>> +                       xlnx,trig1-assert =3D <0x1>;
>>>>> +               } ;
>>>>>
>>>>
>>>> It seems you are missing a mandatory "#pwm-cells" property.
>>>> How is anybody supposed to use this?
>>>>
>>>>      Arnd
>>>>
>>>
>>> I've added some additional information in the documentation
>>>
>>>
>>>
>>> Xilinx PWM controller
>>>
>>> This driver works together with the Xilinx Axi timer hardware core.
>>> The core is available for the microblaze, powerpc and arm based Xilin=
x
>>> platforms.
>>>
>>> The axi timer core is implemented in the pl (programmable logic) of t=
he
>>> fpga. The amount is user defined. Each core has two timers and one pw=
m output.
>>
>> For PWM you have to have 2 timers but core itself can be configured
>> to any configuration and I expect that any output has to be used.
>>
>> Can you describe me your testing enviroment with zedboard?
>> Do you use any additional hw or are using just leds or any device
>> on zedboard?
>>
>> Thanks,
>> Michal
>>
>>
>=20
> I'm using the 2 internal timers of the axi_timer core. I've attached th=
e pwm output of the timer core to one of the leds. The generate out0 and =
generate out1 signals aren't attached.
> I've added 4 axi timers to the design, so I can use the 4 leds of zedbo=
ard to visualize and measure the pwm signal.

ok, that's configuration what I expected.
Can you add or just send me this hw design? I can create it myself but
no reason to spend time on it when you have it.

Thanks,
Michal



--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--28E88AGEvL81Xrxa9uxRQ5ugIqRhvlnq4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlN0qwwACgkQykllyylKDCHt9wCfY1nNgmkcVc7uCzNaLFkrDcQL
MHoAn0XBVl6mzHc0395P4iOwdLAeQOgy
=Uxry
-----END PGP SIGNATURE-----

--28E88AGEvL81Xrxa9uxRQ5ugIqRhvlnq4--
