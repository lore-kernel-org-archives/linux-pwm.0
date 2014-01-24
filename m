From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/2] PWM: let of_xlate handlers check args count
Date: Fri, 24 Jan 2014 08:41:03 +0100
Message-ID: <20140124074103.GJ16215@pengutronix.de>
References: <20140123083714.3c6e86ae@ipc1.ka-ro>
 <1390467898-9216-1-git-send-email-s.hauer@pengutronix.de>
 <1390467898-9216-2-git-send-email-s.hauer@pengutronix.de>
 <20140123115632.6d3f1a58@ipc1.ka-ro>
 <20140123110444.GI16215@pengutronix.de>
 <20140123165349.GY15937@n2100.arm.linux.org.uk>
 <20140123173642.GZ15937@n2100.arm.linux.org.uk>
 <20140124064254.0369084d@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51634 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbaAXHla (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jan 2014 02:41:30 -0500
Content-Disposition: inline
In-Reply-To: <20140124064254.0369084d@ipc1.ka-ro>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lothar =?iso-8859-15?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Landley <rob@landley.net>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org

On Fri, Jan 24, 2014 at 06:42:54AM +0100, Lothar Wa=DFmann wrote:
> Hi,
>=20
> > Okay, this works, but there's a problem with pwm-leds.
> >=20
> > When the duty cycle is set to zero (when you set the brightness to =
zero)
> > pwm-leds decides to disable the PWM after configuring it.  This cau=
ses
> > the PWM output to be driven low, causing the LED to go to maximum
> > brightness.
> >=20
> > So, using the inversion at PWM level doesn't work.
> >=20
> The problem is that the driver calls pwm_disable() when the duty cycl=
e is 0.
> This sets the PWM output low independent from the output polarity set=
ting.
>=20
> > To make this work correctly, we really need pwm-leds to do the inve=
rsion
> > rather than setting the inversion bit in hardware.
> >=20
> The same holds for the pwm-backlight driver.
>=20
> The easiest fix would be not to call pwm_disable() even for a zero du=
ty
> cycle.

IMO that's the right thing to do anyway due to the different PWM
hardware controllers we have. I'm thinking about the following patch
for some time.

Sascha

--------------------8<--------------------------

=46rom 9ebbc3d72c71bd97d7fc4458f60ae3ecd5876984 Mon Sep 17 00:00:00 200=
1
=46rom: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 24 Jan 2014 08:34:16 +0100
Subject: [PATCH] PWM: Document disabled PWM output as undefined

When disabled PWM hardware reacts differently. Some controllers
just stop with their current value, others produce a constant high
or low output, sometimes depending on the output inversion bit. Update
the documentation to reflect that and request from the PWM consumer
drivers to set a constant high/low value with duty cycles of 0/100%
instead of disabling the PWM.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 Documentation/pwm.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 93cb979..b7e8a31 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -44,6 +44,8 @@ After being requested, a PWM has to be configured usi=
ng:
 int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns);
=20
 To start/stop toggling the PWM output use pwm_enable()/pwm_disable().
+The output of a disabled PWM is undefined. Set the duty cycle to 100%
+for a constant high output and to 0 for constant low output.
=20
 Using PWMs with the sysfs interface
 -----------------------------------
--=20
1.8.5.2

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
