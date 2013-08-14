Date: Wed, 14 Aug 2013 11:44:36 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: renesas-tpu: Add DT support
Message-ID: <20130814094436.GD2084@ulmo>
References: <1374791261-9850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Content-Disposition: inline
In-Reply-To: <1374791261-9850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2013 at 12:27:41AM +0200, Laurent Pinchart wrote:
> Specify DT bindings for the TPU PWM controller and add OF support to the
> driver.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>
> ---
>  .../devicetree/bindings/pwm/renesas,tpu-pwm.txt    | 28 +++++++++++++++
>  drivers/pwm/pwm-renesas-tpu.c                      | 41 ++++++++++++++++=
++----
>  2 files changed, 62 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm=
=2Etxt
>=20
> This patch depends on the "[PATCH v2 0/4] Add PWM polarity flag macro for=
 DT"
> series that is scheduled for merge in the PWM tree, and should thus go in=
 via
> the same tree.
>=20
> The code has been tested on an Armadillo800EVA with additional platform p=
atches
> that I'm going to submit next.

Applied, thanks.

Thierry

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSC1GEAAoJEN0jrNd/PrOhoVUP/jAMZQEguJ6Y5JHfI6Vcyhp/
RDoNpRThkEq4tfze4ecuLI7S2EvpAYoC1i03uCRpzLIa2eaRKCAQilQ5lITdzMJe
zPaB7qnZcQbCHMmiVI3eglQLSnGAJeFYCqPbe19gDTU+7uW8KScyrXSE0xI6Em1S
9QQhL14NzkRCIjuiu48xcYf5/Q9Mde6E0dBN2vcV/22fwfKVFfygNZZRJMVsDDsv
dUoJbmFptSAS3YVwEgl/mpAXkwmTO1KrhwXfGvXoTsL2lrJqxSATwMKzIPBYDVzO
dkql1KuAg0whl4BJ6LgajeuHP3QqEmSI1mNA4AeadfUyvS94OMiKjZnFBPOPnX/v
I5iF91uWyv0FDkhPDetX/9eU2fxVNNijXmFowhXZPvWghtn9n/tTFfv0oAOeMLWx
FiQV2kmQJ0BTXp7UO1p1P8bEdeullEAcNfVj4KqjIitmy92ltZpOtHR01OMmFSaT
kg/I5uKVYFcNnruxAsVw/tprb2dzzrlDWD6x7DdSz2cbNI3xfvH95XVkBkLXfdUX
IdCxLet95BOHhdRdxyJHtAP3tvySarv+5W2f86ZEZIjo9mEkhu906ilmpom/pBv7
3XXWICvK0E5+q3E7FsprnvoBAVm5DRkYJhzH13HaI6AaqTbnoAE6FfpX3o1uAk1y
2UpFM91SiufbKWjZFr1H
=kVlt
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--
