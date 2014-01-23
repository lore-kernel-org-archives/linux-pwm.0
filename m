From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] PWM: let of_xlate handlers check args count
Date: Thu, 23 Jan 2014 17:36:42 +0000
Message-ID: <20140123173642.GZ15937@n2100.arm.linux.org.uk>
References: <20140123083714.3c6e86ae@ipc1.ka-ro> <1390467898-9216-1-git-send-email-s.hauer@pengutronix.de> <1390467898-9216-2-git-send-email-s.hauer@pengutronix.de> <20140123115632.6d3f1a58@ipc1.ka-ro> <20140123110444.GI16215@pengutronix.de> <20140123165349.GY15937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140123165349.GY15937@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Landley <rob@landley.net>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
List-Id: linux-pwm@vger.kernel.org

On Thu, Jan 23, 2014 at 04:53:50PM +0000, Russell King - ARM Linux wrot=
e:
> On Thu, Jan 23, 2014 at 12:04:44PM +0100, Sascha Hauer wrote:
> > On Thu, Jan 23, 2014 at 11:56:32AM +0100, Lothar Wa=DFmann wrote:
> > > Hi,
> > >=20
> > > Sascha Hauer wrote:
> > > > of_pwm_n_cells for the of_xlate handler is stored in struct pwm=
_chip,
> > > > but it is only ever used by the of_xlate handler itsel. Remove
> > > > of_pwm_n_cells from struct pwm_chip and let the handler do the =
argument
> > > > count checking to simplify the code.
> > > >=20
> > > This still does not make the PWM_POLARITY flag in the pwms node
> > > optional as was the goal because of_parse_phandle_with_args() req=
uires
> > > at least #pwm-cells arguments in the node.
> > >=20
> > > So, with a DT configuration like:
> > > pwm0: pwm@0 {
> > > 	#pwm-cells =3D <3>;
> > > };
> > > backlight {
> > > 	pwms =3D <&pwm0 0 100000>;
> > > };
> >=20
> > We misunderstood each other. My goal was to allow the driver to als=
o
> > work with old devicetrees which specify #pwm-cells =3D <2>, not to =
allow
> > inconsistent devicetrees like the snippet above.
>=20
> In which case, the patch I've posted seems to do that job too... I'm
> just about to test out the three-cell version.

Okay, this works, but there's a problem with pwm-leds.

When the duty cycle is set to zero (when you set the brightness to zero=
)
pwm-leds decides to disable the PWM after configuring it.  This causes
the PWM output to be driven low, causing the LED to go to maximum
brightness.

So, using the inversion at PWM level doesn't work.

To make this work correctly, we really need pwm-leds to do the inversio=
n
rather than setting the inversion bit in hardware.

--=20
=46TTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
