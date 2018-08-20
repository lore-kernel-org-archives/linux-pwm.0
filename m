From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] pwm: mediatek: Add MT7628 support
Date: Mon, 20 Aug 2018 11:39:05 +0200
Message-ID: <20180820093905.GE8242@ulmo>
References: <20180725095209.10641-1-john@phrozen.org>
 <20180725095209.10641-2-john@phrozen.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5738738356857052962=="
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20180725095209.10641-2-john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: John Crispin <john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--===============5738738356857052962==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 25, 2018 at 11:52:09AM +0200, John Crispin wrote:
> Add support for MT7628. The SoC is legacy MIPS and hence has no complex
> clock tree. This patch add an extra flag to the SoC specific data
> indicating, that no clocks are present.
>=20
> Signed-off-by: John Crispin <john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>
> ---
>  drivers/pwm/Kconfig        |  2 +-
>  drivers/pwm/pwm-mediatek.c | 19 ++++++++++++++++++-
>  2 files changed, 19 insertions(+), 2 deletions(-)

Very odd that they would use the same naming scheme for a chip that is
radically different, but they did, so:

Applied, thanks.

Thierry

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlt6jDkACgkQ3SOs138+
s6FUyBAAmysnI2eI9B5HMkl/oRWhlKnm2KnMpfsEp7nLmpv2DgU3dI+mGRF0jv+t
cz5rBYboHBABwIK09y8XRqI7vLV3YtvenSRVPjEtp8Sc+tW5TTC8YmUdS13JBzfR
bto5qLYIbtof9tIGpuLOrzGQWBi9XxrWfhDcYsKbuca7QG5hYc6tmx5FUz2Orr+l
G3SHGA+taQzewi9HtfCxAWzVMJqz5SVcGde6D70X4zhm7S+W6lT5sob/lYHJM4Uy
8GS+4zoQEb5Lz0LZlSxIJgAKHp7GeKPE+gitOVYhoLCoPddG5OMNyKtSFygmns5s
CxFxxTjB6JtZLKX2cwJT4oHUxgLvlUC4LoC0r1yDNrBZ/aDQkbFAxZpl1LKq9tU7
KQdl44n70rKbALaYlGONzSjqePaYSwzOb79RmNi/stITGpxMFxl8P6wCWXP2M/bD
5DBIxa0lTposOMcWhGbYEN6Yn6tkylJkYht0QhkeLvKaGCNAIMFrkZnxwx+AX59G
wyiIeby/9E8IwErAOpOu8YhBKD5KIwEBPuYNgSdLsbk7Laq6FG3NzPfggROX4h/e
5OF7s+fn1/LboCundXO6hmaJOGH2elXM+GoyLGg7+CR/RpeXDGjk5QHq7V15oJk+
kA4T5uATr7IgYgRbWdgb48nchSSt+eLpAxOUgGOz2bWjxUT9OBg=
=i5Vr
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--


--===============5738738356857052962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-mediatek mailing list
Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-mediatek

--===============5738738356857052962==--
