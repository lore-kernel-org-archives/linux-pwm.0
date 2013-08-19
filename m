Return-Path: <laurent.pinchart@ideasonboard.com>
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] pwm: renesas-tpu: Add DT support
Date: Tue, 20 Aug 2013 01:14:25 +0200
Message-ID: <2198434.TehIm1zVvo@avalon>
In-Reply-To: <20130812072157.GA17056@ulmo>
References: <1374791261-9850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1943187.cb9fxEDeXJ@avalon> <20130812072157.GA17056@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13370822.S3R21R0J9I"; micalg="pgp-sha1"; protocol="application/pgp-signature"
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>


--nextPart13370822.S3R21R0J9I
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Thierry,

On Monday 12 August 2013 09:21:58 Thierry Reding wrote:
> On Thu, Aug 08, 2013 at 12:44:42PM +0200, Laurent Pinchart wrote:
> > Hi Thierry,
> > 
> > I'd like to get this patch in v3.12, could you please take it in your tree
> > ?
>
> I'm Cc'ing the device tree bindings maintainers. Given that this uses
> only the standard PWM bindings in the first place I suppose it would be
> okay to take this in, but I'd like to run it past them to make sure.
> 
> > On Friday 26 July 2013 00:27:41 Laurent Pinchart wrote:
> > > Specify DT bindings for the TPU PWM controller and add OF support to the
> > > driver.
> > > 
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > ---
> > > 
> > >  .../devicetree/bindings/pwm/renesas,tpu-pwm.txt    | 28 +++++++++++++++
> > >  drivers/pwm/pwm-renesas-tpu.c                      | 41 +++++++++++----
> > >  2 files changed, 62 insertions(+), 7 deletions(-)
> > >  create mode 100644
> > > 
> > > Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
> > > 
> > > This patch depends on the "[PATCH v2 0/4] Add PWM polarity flag macro
> > > for DT" series that is scheduled for merge in the PWM tree, and should
> > > thus go in via the same tree.
> > > 
> > > The code has been tested on an Armadillo800EVA with additional platform
> > > patches that I'm going to submit next.

[snip]

> > > diff --git a/drivers/pwm/pwm-renesas-tpu.c
> > > b/drivers/pwm/pwm-renesas-tpu.c
> > > index 2600892..3eeffff 100644
> > > --- a/drivers/pwm/pwm-renesas-tpu.c
> > > +++ b/drivers/pwm/pwm-renesas-tpu.c

[snip]

> > >  static struct platform_driver tpu_driver = {
> > >  	.probe		= tpu_probe,
> > >  	.remove		= tpu_remove,
> > >  	.driver		= {
> > >  		.name	= "renesas-tpu-pwm",
> > >  		.owner	= THIS_MODULE,
> > > +		.of_match_table = of_match_ptr(tpu_of_table),
> 
> I'd like to point this out as an example of why I think aligning on the
> = here is a bad idea. Eventually you're bound to add a field which is
> longer than all the others and therefore can't be aligned consistently.
> So instead of coming up with some kind of fancy formatting it often
> turns out better to just use a regular single space around =. That you
> can always consistently use, no matter how long the field names are.

Thanks, I'll keep that in mind.
 
> To be clear, I don't expect you to change the patch because of this.

OK.

-- 
Regards,

Laurent Pinchart

--nextPart13370822.S3R21R0J9I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQEcBAABAgAGBQJSEqbXAAoJEIkPb2GL7hl1hewH/2eB3z0/aenvbxANtXQVP8To
kWQ8yuPNGjsQFxNevfqR9VYflmwTThRghBrqutswBgf68HhZyZTAvUULBubkRvNy
rHSJBeJqY9+uCSNdjuN1uvZ6hZXvR/iAkkYN2bmqE/PAsYHogMpvTDQG+2oqD+SO
LD6ohjT1iuIV9G80uX0MsWKPYq1NK/QIUF5ah7JeIecFJpF807biIu0Rl5xZVy+b
Aj560Dayx3zN7BRfaZgVF7n93NTzUDzIuhZUtNNSSKUykyVL+DH+pNWBqUeCW4ZD
EylG3g0bfeMXC9T4Phcx0oEE+Cm2zzbtQUt3IUoD680c5d9mqN7Cg7sj6zoEaxo=
=3DB5
-----END PGP SIGNATURE-----

--nextPart13370822.S3R21R0J9I--
