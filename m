From: Michal Simek <monstr@monstr.eu>
Subject: Re: [rfc]pwm: add xilinx pwm driver
Date: Fri, 16 May 2014 09:53:50 +0200
Message-ID: <5375C40E.2090904@monstr.eu>
References: <1400066773-14393-1-git-send-email-bart.tanghe@thomasmore.be> <5049141.XmehsUeakV@wuerfel> <5374C773.6070402@monstr.eu> <16896948.U7hTsgDub4@wuerfel>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8U46eKv1e8CjRDdJ0cPKVRTlu51bG6H71"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <16896948.U7hTsgDub4@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bart Tanghe <bart.tanghe@thomasmore.be>, thierry.reding@gmail.com, michal.simek@xilinx.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, grant.likely@linaro.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8U46eKv1e8CjRDdJ0cPKVRTlu51bG6H71
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/15/2014 06:30 PM, Arnd Bergmann wrote:
> On Thursday 15 May 2014 15:56:03 Michal Simek wrote:
>> IP is configurable as is normal for us.
>> You can select IP with just one timer.
>> It means register locations for specific timer are fixed.
>> http://www.xilinx.com/support/documentation/ip_documentation/xps_timer=
=2Epdf
>>
>> timer0 - offset 0x0
>> timer1 - offset 0x10 (doesn't need to be synthesized)
>>
>> There is one interrupt for both timers.
>>
>> Timers can be as timers (up/down count/ reload with or without IRQs)
>> But then one options is to use both timers and generate PWM signal.
>> From full ip description in DT you can see xlnx,gen0-assert =3D <1>;
>> which can suggest that this IP can output PMW signal.
>> (We can also detect if PWM0 signal is connected just to be sure
>> that PWM can be enabled).
>>
>> There is also capture trigger mode where external signal start/stop
>> timer counting.
>>
>> It means there are 3 modes - timer, capture and PWM.
>> Timer (clocksource, clockevent) requires specific handling,
>> PWM has own subsystem and not sure if there is any subsystem for
>> capture mode. Is there any?
>=20
> I don't think so. Possibly somewhere in IIO.
>=20
>> Not every timer configuration is suitable for all things
>> but fully configured timer can be used in all 3 modes.
>>
>>
>> I think that make sense to register and map all timers in the system
>> and classify them with flags (like can't be used for capture or PMW
>> if there are not outputs connected) and then use the best
>> timer for clocksource and clockevent. The best candidate is IP
>> with the lowest IRQ number in dual timer mode but in general
>> whatever timer can be used that's why we can't probably avoid
>> timer specification in DT.
>> In spite of this smells because you are saying via DT
>> to Linux which timer should be used for what purpose.
>=20
> We had discussions about this in the past, but I don't remember the
> outcome of that.

Will be great if someone is able to find out this outcome.
IRC: You can register as many clocksources as you like and core
itself choose the best one - the most accurate one.

But I don't think for our case there is any universal algorithm
which we can use to find out which timer should be used for this
purpose that's why selecting it via DT is probably the best what we
can do.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--8U46eKv1e8CjRDdJ0cPKVRTlu51bG6H71
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlN1xBAACgkQykllyylKDCHVtQCeNv7ZNx0t+AZ9RYFEPPDq478n
DjAAn3S0JKB4KIe8qA4a8zabD13OEP23
=ffsq
-----END PGP SIGNATURE-----

--8U46eKv1e8CjRDdJ0cPKVRTlu51bG6H71--
