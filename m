From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 16/17] pwm: sti: Take the opportunity to conduct a
 little house keeping
Date: Mon, 5 Sep 2016 13:37:56 +0200
Message-ID: <20160905113756.GP31424@ulmo.ba.sec>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-17-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="24/piotZLKF/SXqU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160816093508.28307-17-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, patrice.chotard@st.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--24/piotZLKF/SXqU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2016 at 10:35:07AM +0100, Lee Jones wrote:
> This includes fixing some Coding Style issues and re-ordering/
> simplifying a little code.
>=20
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-sti.c | 40 ++++++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 18 deletions(-)

Applied with a little bikeshedding.

Thanks,
Thierry

--24/piotZLKF/SXqU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzVkRAAoJEN0jrNd/PrOh8LkQALUPCx1vrhwuuG6NboZuVJqs
CjzMUh+KJCvbO5pZCw/z/aFR2vAlgwDwAXYuIGjtZkH1Ydi8ZReCz0LH7LH/BAVH
ZIxOyVH9nfoQlIqcvFWD1xlEVeaZdKVLMH4iG2+tgPfVM2gq4EKOoHrDY+l8ekJJ
QkaRtLQwOj8MwLKaaZIm8u8Qui41Tw8QTYGHSofTISyhIz1pTbKumeJHs/uvr50Q
UCMSZ/PRnFPO2RfN8TqTriyXfT+JJ29Dxvmcv2qRSuSTKDmhG0mw3gg1nMG8SEWT
jXtLcCLe6Z7DKlIh703Rsm3P/Z/+dQFnv/P915o0J+Vc2CSB3YF7MyT4gotBY4y8
wq+MV8LkF59gFVn70DMUFQcl85mJclmSkegqBV0sYCOpcRZG5GtXhT+VYEIm1vhJ
asCxnQN34YwJlnUmLRTh3HdklvL4WAbmvR+cQhitYzxP6wOeBFQqpwSPpS5ihsMa
hmGNsO/mCxlvRset5zdjalsDdOzUIlyLoeme7hpBNJPXBqezNO2wYCpRMFJb+H9l
iUe6zP1CdHsXf/bjMyDzVkbgLhrQJB2G6l/01tvIEoU1UI6LsCJhJQxaYlJZi01o
pAdSsrBsrwz5cMo4kh0UuH/GV5SdKicS/zwlSrFigmAcucjS2gDyhGOy4vu+eDGD
ulHKMNDPRPg4nrqT2CT5
=Nw7o
-----END PGP SIGNATURE-----

--24/piotZLKF/SXqU--
