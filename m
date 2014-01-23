From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv2 2/2] pwm: imx: support polarity inversion
Date: Thu, 23 Jan 2014 16:44:33 +0000
Message-ID: <20140123164433.GX15937@n2100.arm.linux.org.uk>
References: <1389859585-14006-1-git-send-email-LW@KARO-electronics.de> <1389859585-14006-3-git-send-email-LW@KARO-electronics.de> <20140116160356.GY16215@pengutronix.de> <20140123083714.3c6e86ae@ipc1.ka-ro> <20140123115203.GV15937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140123115203.GV15937@n2100.arm.linux.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Landley <rob@landley.net>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Thu, Jan 23, 2014 at 11:52:03AM +0000, Russell King - ARM Linux wrot=
e:
> On Thu, Jan 23, 2014 at 08:37:14AM +0100, Lothar Wa=DFmann wrote:
> > This wouldn't buy much without a material change to of_pwm_get().
> > The function of_parse_phandle_with_args() called by of_pwm_get()
> > requires the number of args in the pwms property be greater or equa=
l to
> > the #pwm-cells property in the pwm node. Thus, the interesting case=
 of
> > having #pwm-cells =3D <3> without changing the existing users is
> > prohibited by of_parse_phandle_with_args().
>=20
> I really don't think that's a problem we need to be concerned with at
> the moment.  What we need is for the kernel to be able to parse files
> with #pwm-cells =3D <2> with the pwms property containing two argumen=
ts,
> and when they're updated to #pwm-cells =3D <3> with the pwms property
> containing three arguments.
>=20
> Yes, that means all the board dt files need to be updated at the same
> time to include the additional argument, but I don't see that as a bi=
g
> problem.
>=20
> What we do need to do is to adjust the PWM parsing code such that it'=
s
> possible to use either specification without causing any side effects=
=2E
>=20
> I would test this, but as u-boot is rather fscked at the moment and t=
he
> networking has broken on my cubox-i as a result... and it seems that =
the
> u-boot developers have pissed off cubox-i u-boot hackers soo much tha=
t
> they've dropped u-boot in favour of barebox...

Okay, finally confirmed that this works with #pwm-cells =3D 2.

--=20
=46TTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
