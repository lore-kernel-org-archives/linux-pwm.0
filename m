From: randy <lxr1234@hotmail.com>
Subject: Re: [exynos4412]How to test a pwm device, is there a test program?
Date: Thu, 12 Dec 2013 22:27:04 +0800
Message-ID: <BLU0-SMTP4320E405FB7D782DEAD759ADDC0@phx.gbl>
References: <BLU0-SMTP2611DD3F4485EEE457F4920ADD00@phx.gbl> <20131209085225.GA27868@ulmo.nvidia.com> <BLU0-SMTP1651F8FA9BEEB0257791F09ADD30@phx.gbl> <20131209115523.GA17693@ulmo.nvidia.com> <BLU0-SMTP30A197FE32DA623BBA7713ADD30@phx.gbl> <20131212122204.GG11524@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from blu0-omc4-s37.blu0.hotmail.com ([65.55.111.176]:6060 "EHLO
	blu0-omc4-s37.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751542Ab3LLO1L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Thu, 12 Dec 2013 09:27:11 -0500
In-Reply-To: <20131212122204.GG11524@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

=E4=BA=8E 2013=E5=B9=B412=E6=9C=8812=E6=97=A5 20:22, Thierry Reding =E5=
=86=99=E9=81=93:
> On Mon, Dec 09, 2013 at 09:06:37PM +0800, randy wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>=20
>> =E4=BA=8E 2013=E5=B9=B412=E6=9C=8809=E6=97=A5 19:55, Thierry Reding =
=E5=86=99=E9=81=93:
>>> On Mon, Dec 09, 2013 at 07:04:12PM +0800, randy wrote: [...]
>>>> Actually, I don't know whether the pwm works or not. In
>>>> dmesg, I saw: [  853.690000] samsung-pwm 139d0000.pwm: tried
>>>> to request PWM channel 0 without output [  876.930000]
>>>> samsung-pwm 139d0000.pwm: tried to request PWM channel 0
>>>> without output [ 879.615000] samsung-pwm 139d0000.pwm: tried
>>>> to request PWM channel 1 without output
>>>>=20
>>>> in my dts, I only add =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
>>>> pwm@139D0000 { status =3D "okay";
>> I added samsung,pwm-outputs =3D <0>;
>>>> }; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D is it enough to make pwm
>>>>  work, if the driver in kernel has been correct.
>>>=20
>>> It seems like you're missing the samsung,pwm-outputs property
>>> (see Documentation/devicetree/bindings/pwm/pwm-samsung.txt).
>>>=20
>>> Thierry
>>=20
>> Well I have make it output to channel 0 now. But it doesn't work
>> with the config below. As it is a buzzer, I change your config.=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D root=
@mifu:~# cat
>> /sys/class/pwm/pwmchip0/pwm0/enable
>>=20
>> 1 root@mifu:~# cat /sys/class/pwm/pwmchip0/pwm0/period 1000000=20
>> root@mifu:~# cat /sys/class/pwm/pwmchip0/pwm0/duty_cycle 500000=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D I=
 have used a
>> function generator with Vpp=3D2.2, it works.
>=20
> Are you sure the function generator runs at the same frequency? Do
> you
Yes, I am sure.
> have the possibility to check the PWM output with a scope to see if
> it outputs anything?
I have used a oscillograph to capture, nothing(althought it show some
waves, but it is nosie single captured by autoset). I have a scope but
I don't think there is any different.
>=20
> Thierry
Ayaka
Thank you
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJSqce4AAoJEPb4VsMIzTzikV4H/3NF4D2kcHYYt6axhgdnlDaI
rHUVYBDHcWR0gDUY6rHN7eyStCKWdGzant0pR8AcPOSTYStwXJbFnoqPHPb9sI2J
KU/EmhA+YOCzIlxeagovpFmlGopVQEWPbKM99txzljsIvjOD4xKZ2kSQv4L/QHLc
CHyi1p9NzL1uSz4h5N5XcpMiMWHSNbCBXWgjqejseTjli9n1A0o0ehY5Ip9507un
rYfJETB+imHOck9TH9Rol1QdS7PjIpInFMZiqkzxWKnjFXrlNQJujzPlgoJCTrv3
XIci86cnK9F2DEqkl3tJ1XsxMp0LlfEn45ZCKySeuZ2muyYpBSAHPo0uOj0DcEM=3D
=3DL3au
-----END PGP SIGNATURE-----
