From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 13/14] regulator: pwm: Support extra continuous mode
 cases
Date: Tue, 5 Jul 2016 16:34:23 +0200
Message-ID: <20160705143423.GA6247@sirena.org.uk>
References: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
 <1465895602-31008-14-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XgWkusiZDs53F1ax"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1465895602-31008-14-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Stephen Barber <smbarber-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ajit Pal Singh <ajitpal.singh-qxv4g6HH51o@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--XgWkusiZDs53F1ax
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 14, 2016 at 11:13:21AM +0200, Boris Brezillon wrote:
> The continuous mode allows one to declare a PWM regulator without having
> to declare the voltage <-> dutycycle association table. It works fine as
> long as your voltage(dutycycle) function is linear, but also has the
> following constraints:

Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

--XgWkusiZDs53F1ax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXe8VtAAoJECTWi3JdVIfQFAIH/10DhvqHXHqj8fZ2piJt4+TN
OveODsZV0HFJVnHsiDYJJqZoHef2Jqfk0/jmHZp24Q8tQzqfYmNbXKIdt31ZgewT
PdK27pCkBKay7db2VpCvMGl5RfS6Jy/+Em8S9vYyuHfN4QhnoHXSbMvN/zz5sc+/
+RK5VZKqsSvh8c+E/afn9ekOgpQcnyANOBcQqCdfjKa51k6H5yxt8RerilxrYYsu
1/WyENYDmvllqVLPHvnUTr5bVYw77sg0Omv1JidYNhtskJju+kpsN07PbgjyAm8s
zIGCXWvyMxsG0VOY1UQgottCO37c3RiOXQ+ezanuu4d2QVFboycnulVaV6A9Nlo=
=BbrB
-----END PGP SIGNATURE-----

--XgWkusiZDs53F1ax--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
