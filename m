From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 00/10] pwm: add support for atomic update
Date: Mon, 20 Jul 2015 21:08:19 +0100
Message-ID: <20150720200819.GN11162@sirena.org.uk>
References: <1437406327-6207-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150720171950.GE11162@sirena.org.uk>
 <20150720214913.73c47fa6@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tOEJyvZxeaoVWcY4"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150720214913.73c47fa6@bbrezillon>
Sender: linux-leds-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Doug Anderson <dianders@google.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org


--tOEJyvZxeaoVWcY4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 20, 2015 at 09:49:13PM +0200, Boris Brezillon wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Jul 20, 2015 at 05:31:57PM +0200, Boris Brezillon wrote:

> > > - dropped pwm-regulator patches (should be submitted separately)

> > I think the second patch needs to go in with this series doesn't it?  It
> > was just the enable one that was good to go immediately IIRC.

> I was planning on submitting those two patches after the PWM changes
> have been merged, but you're right, maybe we should think about a proper
> way to smoothly get all of them in the same release.

I see.  We should at least try to get the enable one in this time, I'd
like to just apply it and then either do a cross tree merge for the one
making use of the new functionality or (if the rest of the series gets
held up for some reason) just letting it get merged via Linus' tree.

> I have rebased my work on top your regulator/topic/pwm branch containing
> Lee's work [1].

> Note that patch 1 has changed a bit to take Lee's additions into
> account.

> Thierry, could you create a branch based on Mark's regulator/topic/pwm
> branch ?
> If everybody agrees on the solution I'll send a v3 rebasing my work on
> top of this topic branch.

I think that's fine for me, I can tag the PWM branch in my tree and
Thierry can pull that.

--tOEJyvZxeaoVWcY4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVrVUyAAoJECTWi3JdVIfQs+wH/iqSyJYwzHG6KAcehMfPKiEC
1OVQZS/wlHBsKPBTUPPt1yIgD3leQG/lQI4kDOtYRUSiz0u5qrRe+T2NHsDAWpVD
e1ArnTPxzERvGw95n3ZNT3rHtBWOIDhNwF7STVnlxYaMytgbdQghQOS4TwupwvwR
mTQ4C6VMJvkOscth9QQ5EbC4+M0LghXtFdttIthi7EMZiSP2lcbDpZ+cxp96Uonp
TPPS8fxDfY5v/DwToB7L4uYzxDbHK74xjtEuFssJNcykyul6QyS4NuYgi3mPnhxg
gFUHHbYbUJMzTDxg9yRNjdqJfDX455ee7DdCXuuWT09gbL2tAPqcO6OhldeZgJk=
=dllH
-----END PGP SIGNATURE-----

--tOEJyvZxeaoVWcY4--
