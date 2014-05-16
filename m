From: Michal Simek <monstr@monstr.eu>
Subject: Re: [rfc]pwm: add xilinx pwm driver
Date: Fri, 16 May 2014 10:44:28 +0200
Message-ID: <5375CFEC.6070008@monstr.eu>
References: <1400066773-14393-1-git-send-email-bart.tanghe@thomasmore.be> <5049141.XmehsUeakV@wuerfel> <5374C773.6070402@monstr.eu> <16896948.U7hTsgDub4@wuerfel> <20140515204941.GB7136@mithrandir>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="oNpEpmClw9SQNoEwwAAJT4gnvquRAJgco"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140515204941.GB7136@mithrandir>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Bart Tanghe <bart.tanghe@thomasmore.be>, michal.simek@xilinx.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, grant.likely@linaro.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Porter <matt.porter@linaro.org>
List-Id: linux-pwm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oNpEpmClw9SQNoEwwAAJT4gnvquRAJgco
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/15/2014 10:49 PM, Thierry Reding wrote:
> On Thu, May 15, 2014 at 06:30:13PM +0200, Arnd Bergmann wrote:
>> On Thursday 15 May 2014 15:56:03 Michal Simek wrote:
>>> IP is configurable as is normal for us.
>>> You can select IP with just one timer.
>>> It means register locations for specific timer are fixed.
>>> http://www.xilinx.com/support/documentation/ip_documentation/xps_time=
r.pdf
>>>
>>> timer0 - offset 0x0
>>> timer1 - offset 0x10 (doesn't need to be synthesized)
>>>
>>> There is one interrupt for both timers.
>>>
>>> Timers can be as timers (up/down count/ reload with or without IRQs)
>>> But then one options is to use both timers and generate PWM signal.
>>> From full ip description in DT you can see xlnx,gen0-assert =3D <1>;
>>> which can suggest that this IP can output PMW signal.
>>> (We can also detect if PWM0 signal is connected just to be sure
>>> that PWM can be enabled).
>>>
>>> There is also capture trigger mode where external signal start/stop
>>> timer counting.
>>>
>>> It means there are 3 modes - timer, capture and PWM.
>>> Timer (clocksource, clockevent) requires specific handling,
>>> PWM has own subsystem and not sure if there is any subsystem for
>>> capture mode. Is there any?
>>
>> I don't think so. Possibly somewhere in IIO.
>=20
> I think so too. There was a patch set not so long ago that added PWM
> capture support for one of the TI PWM controllers to IIO.

It is probably this.
https://lwn.net/Articles/583998/
https://lkml.org/lkml/2014/2/5/378

There were some comments in v3 which haven't been fixed.
Matt: What's the status on this?

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--oNpEpmClw9SQNoEwwAAJT4gnvquRAJgco
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlN1z/IACgkQykllyylKDCEGhwCaAktbn+VB6o1QuvXYMI8apUDy
k5EAoIfPdREPcAS0HnZjKjsU8If1NjWf
=wkuF
-----END PGP SIGNATURE-----

--oNpEpmClw9SQNoEwwAAJT4gnvquRAJgco--
