From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: Add MT7628 information
Date: Mon, 20 Aug 2018 11:39:18 +0200
Message-ID: <20180820093918.GF8242@ulmo>
References: <20180725095209.10641-1-john@phrozen.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8226584202089992473=="
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20180725095209.10641-1-john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>
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


--===============8226584202089992473==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
Content-Disposition: inline


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 25, 2018 at 11:52:08AM +0200, John Crispin wrote:
> Enhance the MediaTek PWM binding with details about the IP found in the
> MT7628 SoC.
>=20
> Signed-off-by: John Crispin <john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlt6jEYACgkQ3SOs138+
s6GMjg//VtjaSeuNnfriujuVCungEywVeBLAjZsQO88Nj7pacmeMNJYuZBlOr7Ts
vj9ta0WCJx+b7nhK6jjrnNmS7bWQ6Kym7qBm1RbVJQRgd1dgbvbL/PNEV8IrqGuo
Fl1PnIuJkOTi/fzfM3PPFY5WMgA2eR8ekZOIUC2AA/DhP5Fbe6hY02SDQyJEUp9B
hUcIIZFIZfTY04qQlUDEVAdPF8qHDDSnU6Mh/r816e59fDLnanZK4tBkAifULQFl
HThAWBtYTS2UFpQTNaDXm7d99IUT7vyf0Ds/otqVWLS111mx7c69mG148S4yEg24
wXGC3yI+yXzN2124rmR8J035jklzx+6ejBqX71OEzBU3yocHYx91y6wki2GmXdDn
+1JxGQSp8FVjiwKBls29mAFSg1RpmXFF9pX0HMNFUAIlBL7TZnDwXffYzilc6ypV
Snm/8ZsBvfxYjGrFCFPg7Af0WfiP/F/LI9nauUnXqY2EuAIjTLOIzGaoK/uxk3ZK
Y4YHZthzVgHftUHDRIQgbrhX/V77/eb5/8rlzJ6h8nu33iDX+7sT6EQstMvAjnlp
AhtllKKRXZdd1LkL+m+VMYWQ6vgEBsT42v1ILQ6HPV86OxpWcn1F78lMq0UM26m3
oDufV55ksBgpbFR9ok6RdujDw13EaeehcOqoxBbBFxJIMNx+Wq8=
=HVR0
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--


--===============8226584202089992473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-mediatek mailing list
Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-mediatek

--===============8226584202089992473==--
