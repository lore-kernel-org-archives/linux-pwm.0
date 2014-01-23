From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/2] PWM: let of_xlate handlers check args count
Date: Thu, 23 Jan 2014 12:04:44 +0100
Message-ID: <20140123110444.GI16215@pengutronix.de>
References: <20140123083714.3c6e86ae@ipc1.ka-ro>
 <1390467898-9216-1-git-send-email-s.hauer@pengutronix.de>
 <1390467898-9216-2-git-send-email-s.hauer@pengutronix.de>
 <20140123115632.6d3f1a58@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59630 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbaAWLFQ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Jan 2014 06:05:16 -0500
Content-Disposition: inline
In-Reply-To: <20140123115632.6d3f1a58@ipc1.ka-ro>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lothar =?iso-8859-15?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 23, 2014 at 11:56:32AM +0100, Lothar Wa=DFmann wrote:
> Hi,
>=20
> Sascha Hauer wrote:
> > of_pwm_n_cells for the of_xlate handler is stored in struct pwm_chi=
p,
> > but it is only ever used by the of_xlate handler itsel. Remove
> > of_pwm_n_cells from struct pwm_chip and let the handler do the argu=
ment
> > count checking to simplify the code.
> >=20
> This still does not make the PWM_POLARITY flag in the pwms node
> optional as was the goal because of_parse_phandle_with_args() require=
s
> at least #pwm-cells arguments in the node.
>=20
> So, with a DT configuration like:
> pwm0: pwm@0 {
> 	#pwm-cells =3D <3>;
> };
> backlight {
> 	pwms =3D <&pwm0 0 100000>;
> };

We misunderstood each other. My goal was to allow the driver to also
work with old devicetrees which specify #pwm-cells =3D <2>, not to allo=
w
inconsistent devicetrees like the snippet above.

Sascha

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
