Return-path: <kernel-bounces@pengutronix.de>
Date: Thu, 9 May 2019 17:22:14 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20190509152214.GF8907@ulmo>
References: <20190325094934.10221-1-u.kleine-koenig@pengutronix.de>
 <20190325094934.10221-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xkJEvbTYpfqRozZ0"
Content-Disposition: inline
In-Reply-To: <20190325094934.10221-2-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] pwm: samsung: don't uses devm-functions in .request
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>


--xkJEvbTYpfqRozZ0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2019 at 10:49:34AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> A call to .request() is always paired by a call to .free() before a given
> device is disposed. So the simplification that usually is possible when
> using devm-functions cannot be used here. So use plain kzalloc() and
> kfree() for improved runtime behaviour and reduced memory footprint.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-samsung.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, and dropped the chip->dev parameter while at it to make this
actually build.

Thanks,
Thierry

--xkJEvbTYpfqRozZ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzURaYACgkQ3SOs138+
s6HjBBAAtZemmlMmdjKFa/PdYdYRAqmlWRtuwUgsmS4VWc5pCQNJWulVIQseFMiF
WSZGKgI6j2b6WDjmZRQuCgd9nV78dXOuL7RQM3RYT2tozDQHSbEkbd/t0Ye+J7yF
fcpcpgX0Xy29enS7CuAIhAZ0kZryhi3zvHnQO+jdEhU2oaZkTqj7r/dddtS7kT0C
Z9Uzo4M396PHLRmGcvFiS3xswcRlJfkHANYpnTuTuui9nHVAuWP6zbj18+xGf4XE
nSvs5GbjdCSL1oFSJ3WUrI5nf1mF1Ct7oNGH9TUPXoT294RaThoNFzBI39OFTRAj
yUwXPqRrvbp2COCEnetz6D4KZn9vAhLqry+2f6NGmQgLaWfbz2b4OlcN42vWVPvy
XknnXH5pPW+RW5/BAhv5n1xfJUjQfC7MSXQlX3FQio8l45W6rV39EzHuOEJaJiYP
xDbzDvzrPAlJaQS+ze8/tB9Ydsys4GsmMAyZB/D9GVGp71+oY7oQmdDVHGSXZGle
2RYCLnazAkhYa11hFSQ8VjKb8y71hsDVxmvNVOUmlcoMBy7Igo91wId1zQCJySx5
4+X02jmfFdyjHJHLMCV3nrG8gsfkAT/DldhUisQl8DHJ4QGFSSVLtTLGOQllhz5V
81T7DCsDQ73NUHx7XqsOLcNrisWC+LqfPzv3TNR/xxR9pC+H/4s=
=XtqK
-----END PGP SIGNATURE-----

--xkJEvbTYpfqRozZ0--
