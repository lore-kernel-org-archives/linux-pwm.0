Return-Path: <laurent.pinchart@ideasonboard.com>
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] pwm: renesas-tpu: Add DT support
Date: Wed, 21 Aug 2013 13:36:38 +0200
Message-ID: <1966878.F7c9U0lHrH@avalon>
In-Reply-To: <20130814094436.GD2084@ulmo>
References: <1374791261-9850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20130814094436.GD2084@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2384921.BjpBig5VEk"; micalg="pgp-sha1"; protocol="application/pgp-signature"
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org


--nextPart2384921.BjpBig5VEk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Thierry,

On Wednesday 14 August 2013 11:44:36 Thierry Reding wrote:
> On Fri, Jul 26, 2013 at 12:27:41AM +0200, Laurent Pinchart wrote:
> > Specify DT bindings for the TPU PWM controller and add OF support to the
> > driver.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  .../devicetree/bindings/pwm/renesas,tpu-pwm.txt    | 28 +++++++++++++++
> >  drivers/pwm/pwm-renesas-tpu.c                      | 41 +++++++++++++----
> >  2 files changed, 62 insertions(+), 7 deletions(-)
> >  create mode 100644
> >  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt> 
> > This patch depends on the "[PATCH v2 0/4] Add PWM polarity flag macro for
> > DT" series that is scheduled for merge in the PWM tree, and should thus
> > go in via the same tree.
> > 
> > The code has been tested on an Armadillo800EVA with additional platform
> > patches that I'm going to submit next.
> 
> Applied, thanks.

Thank you. I can't find the patches in git://gitorious.org/linux-pwm/linux-
pwm.git, have you applied them elsewhere ?

-- 
Regards,

Laurent Pinchart

--nextPart2384921.BjpBig5VEk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQEcBAABAgAGBQJSFKZMAAoJEIkPb2GL7hl1iTsH/2HipO5RccQJVa4K5zovH0GW
uRqGt4PRNlrIntWef2q/gTDteDM97RtsFKHbew/dPOvicWB/QANiEEBThl+wGu3I
u1IJz7knTHCiyHugb7PGBtAZhsq3eKrRah5CvZRCw8E2HAO45LDZy/W/nOhgGESU
kYOasLo9fpt4M2mb1J7M7Bjv5gEfX58RUE9hMC3ZEXxvEquqaymn496rAnmaAYcx
yDITpFIzBf8kbuTNoiKJtdVgcY9byIF4jN41Mcth3Y8YVZ0LzQtntGmNeuSZlrJZ
ORN/LyQcoLulBL44iE+SonNP8JQi2nsHs0rc9lwx24gE4/RKg/excitHrlXHvcg=
=bBaK
-----END PGP SIGNATURE-----

--nextPart2384921.BjpBig5VEk--
