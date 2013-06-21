Return-Path: <laurent.pinchart@ideasonboard.com>
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 1/5] pwm: Add Renesas TPU PWM driver
Date: Fri, 21 Jun 2013 14:20 +0200
Message-ID: <2751549.f626ATFeLa@avalon>
In-Reply-To: <20130621093119.GB31464@manwe>
References: <1371142488-2514-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1371142488-2514-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20130621093119.GB31464@manwe>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2505733.ELPyzLg66y"; micalg="pgp-sha1"; protocol="application/pgp-signature"
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-pwm@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>


--nextPart2505733.ELPyzLg66y
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Thierry,

On Friday 21 June 2013 11:31:20 Thierry Reding wrote:
> On Thu, Jun 13, 2013 at 06:54:44PM +0200, Laurent Pinchart wrote:
> > The Timer Pulse Unit (TPU) is a 4-channels 16-bit timer used to generate
> > waveforms. This driver exposes PWM functions through the PWM API for
> > other drivers to use.
> > 
> > The code is loosely based on the leds-renesas-tpu driver by Magnus Damm
> > and the TPU PWM driver shipped in the Armadillo EVA 800 kernel sources.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > Tested-by: Simon Horman <horms@verge.net.au>
> 
> Applied, thanks.

Thank you.

-- 
Regards,

Laurent Pinchart

--nextPart2505733.ELPyzLg66y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQEcBAABAgAGBQJRxET2AAoJEIkPb2GL7hl1q/4H/2ZoKIRip3n+/JiLXPo4jKU9
+yLFiJRUSrDRIuzvQfDsWtgUeATMPYkWNa+b27epBLQZ3uV3atgnXuDtmFuphhTg
SJ2CGqg26edzZhcPYd/kZDqFTxFOT7VbQDzFxQAsJ/hRaS2z12i0Getp3MnanfMV
70jBoxYb4DM1vz/khdglhX3LZjP7v5wUaXzgSq8Cp3hoFxGaE9mqqpQGcnW3cuZO
2/EGhj7fFsRv+CmvaW0IGj99f6i2p6p0S3vaFBIknV+Cc16J/2UR4oABI4utYU1E
ki8VRHZPtYCbNQyCN5niYgjBPV/wHOW/Lk5WU5xfnhzJs+YXsPDPSot0Xi6p5tM=
=3TPR
-----END PGP SIGNATURE-----

--nextPart2505733.ELPyzLg66y--
