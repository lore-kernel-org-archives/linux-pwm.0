From: Mark Brown <broonie@kernel.org>
Subject: Re: PWM...
Date: Mon, 20 Jan 2014 16:11:47 +0000
Message-ID: <20140120161147.GS17314@sirena.org.uk>
References: <20140119164956.GR15937@n2100.arm.linux.org.uk>
 <CAOesGMi7g=PHjzhkuObkeu+P_c6kUz5uFcND7euafUW56CvsnQ@mail.gmail.com>
 <20140119193026.GS15937@n2100.arm.linux.org.uk>
 <201401192126.41543.arnd@arndb.de>
 <20140120001446.GD9752@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oXUzUgc67Nrfa9SE"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:57186 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbaATQML (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2014 11:12:11 -0500
Content-Disposition: inline
In-Reply-To: <20140120001446.GD9752@verge.net.au>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pwm@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, "arm@kernel.org" <arm@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--oXUzUgc67Nrfa9SE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 20, 2014 at 09:14:46AM +0900, Simon Horman wrote:
> On Sun, Jan 19, 2014 at 09:26:40PM +0100, Arnd Bergmann wrote:

> > Right: if you change an existing dts file from #pwm-cells=<2> to
> > #pwm-cells=<3>, that requires changing all references to the pwm

> Would this change imply that old dtbs would no longer work with new kernels?

So long as the code can still handle both values for #pwm-cells existing
DTBs should work fine.

--oXUzUgc67Nrfa9SE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS3UrAAAoJELSic+t+oim9kvQP+wdej/aMs043+Gb17yKzCrmI
/fxt8f+0e23W3a2mumeMWwjlBJXaBc+MNam5GgAOB/HLobTBeb75N/PjyGLvNHR0
biuQAf/sLstKiftoAo4WcxHpA3Y8eiutnPIkNHSluyX3Pcb/KKGPro2TlL1C41MO
78Qt8zgjTKLrKl65zsUZzsW/W5xAHPGdtUt6vwWKkB4Z6+v8dAtHmM2x8yB4nC9v
aG37OftkdAgCPEho7NoDiv26nBRdNHqxcKPRhLrdq4ljvtD9dIly/WLzXW56YGp/
MSYp/sC63bza7Ck6y7w+szXh4xbUp+rey92btLDBtT0/P6mcF6GJsh0MkgdrgTm+
av8ElJHBXtimpBx/TCfBXASh5XT4YDnWA11ZxzS5vRcrFo0SWFoqlDycZjgglJsA
zjfbf/SwNZw0gMQmmA6r5N5ek0OOgqu1uFkbH1BoKLzJRjoEIu26rz7gbQpWAHMf
TXgv5SeKSFQcUCltTZyTYGUFalUrHoqkloBiRn/V/bbC6NCljUTxqIUwfgIXvnE3
Ii/c7T25Uk9EANGaEn8DyCUAj+uku8u6lBokaAVZEctUybT3HUETlUdh0T2cMsWd
tr2kM3al38e6ZgB206RI1tucI99JYAZjwI1Bt3SnY7gbZQiWCt1+06E95qinoFQQ
MGmcjAlyqqux/T2oglg8
=ROZ3
-----END PGP SIGNATURE-----

--oXUzUgc67Nrfa9SE--
