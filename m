From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 01/13] pwm: Add new helpers to create/manipulate PWM
 states
Date: Fri, 10 Jun 2016 18:47:46 +0200
Message-ID: <20160610164746.GB8696@ulmo.ba.sec>
References: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
 <1465403688-17098-2-git-send-email-boris.brezillon@free-electrons.com>
 <20160610152109.GQ27142@ulmo.ba.sec>
 <20160610182942.5e7485ff@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160610182942.5e7485ff@bbrezillon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Stephen Barber <smbarber-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ajit Pal Singh <ajitpal.singh-qxv4g6HH51o@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 10, 2016 at 06:29:42PM +0200, Boris Brezillon wrote:
> On Fri, 10 Jun 2016 17:21:09 +0200, Thierry Reding <thierry.reding@gmail.=
com> wrote:
> > On Wed, Jun 08, 2016 at 06:34:36PM +0200, Boris Brezillon wrote:
[...]
> > > + * according to your need before calling pwm_apply_state(). =20
> >=20
> > Maybe mention that the ->duty_cycle field is explicitly zeroed. Then
> > again, do we really need it? If users are going to overwrite it anyway,
> > do we even need to bother? I suppose it makes some sense because the
> > current duty cycle is stale when the ->period gets set to the value from
> > args. I think the documentation should mention this in some way.
>=20
> Yes, if we keep the current duty_cycle it can exceed the period value.
> I'm fine dropping the ->duty_cycle =3D 0 assignment and documenting the
> behavior.

Actually what I was trying to suggest is that we keep the code as-is but
document the behaviour (and rationale behind it).

I think it's fine to zero out the value precisely because it could
become invalid after the function (and there's no other reasonable value
to set it to). Just wanted to make sure it's all properly documented.

Thierry

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXWu8yAAoJEN0jrNd/PrOhZhgQALVk/163hWBe0x7iQpEwsnrc
3Tfjwfiis9ACiwMsCz18zf0ZHHm3bKPkSm0oFGgJ4CJQRjDyXvv2rGZWKvzXT29p
deUBwRe8jQ2KgeMlBjPDGEdM8NgCTgd+YB4G985Yb2F1B5xktK6W09c2bE+kCwsn
X5X2EroaMMqn0L8ErLItNUt+vjkxt5g5S5oagCyZZ11QEklCYnAx+lWTK8aB8xTo
VM5wcnEucmUZyuIz165QYx2x6oIx3EgdRkULiHuv4Mo4k3aR6yxasSEKBSfznpYv
o0rMwe4ShZqUHIb/ctnwZ3fhSK9GSy43IIaIW1f6Mq6UHLpMd4p2uZQJzCmNyx/Q
wp5haH/U6RWeNVUCXsM192O+ml5iwX8tSFGpspZ/oHnR5Y26pmwO2zFVQmO+4cOP
EdHOgjXSehEq/oNBH0Fx54gQFIdQmbe6SuDrQXi+glzWrb8BSo59rWMovbz+QrXI
YN8qTtZrzP7gnF0ezNajno+5ekgclfmRXxm0HNJ9nxLxP5zKK39Oit5crKJq0OyQ
FD1rckyXzMJ71GvrCSpGTu2RWHjT7EppjiLFw4pGrkn5VQuznb2gDOG1odBrWS+p
9PQg4f5TsLiaNAWWgE1ex5QMv+ApFJ41s3Alkwxo+O/CU4QQJCYFNjgqTfjTu1Er
D8P2qQNzrRry/fyVMaVj
=DUCF
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
