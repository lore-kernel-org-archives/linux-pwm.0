From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: pwm-rcar: Revise the device tree binding document
 about compatible
Date: Fri, 6 Nov 2015 15:18:18 +0100
Message-ID: <20151106141818.GA4988@ulmo>
References: <1444130908-8180-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444130908-8180-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 06, 2015 at 08:28:28PM +0900, Yoshihiro Shimoda wrote:
> The compatible should be "renesas,pwm-rcar", and one the the SoC
> specific string. So, this patch revises the documentation.
>=20
> Reported-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

Thierry

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWPLaoAAoJEN0jrNd/PrOhRl0QAKwhgNrFcoxkgzj28F9fMUO0
wmq30941HLS33kPxky9D/6u8D4pbBJmk58OM3meQ6XdkTFhhlIGE/BzlizsP/EjU
8TWzvy7ViOnYp3J/jyK9FuGpaGsL8wRqBCTdG92ElaW4gpvdrmivCZze41XQ1PAD
nQC+/fr/TK7dA55NNiIwMfwvhkVEXCYPuRWXNNyre3Fbly88lV7LaekpQccTsglO
fL4z4CEnmW3IhUFm3/hXwncRSjs9YaPT3ZPNOAMWCnGLIc5O8HdEvg1hc7TK83YA
yJoRERTN+dHr6ZDxgO6Uzdk6VnzKYCzpY4rAMjZTdIQOQO2pDWSBBJjJkCKefFAB
ZJm5vbrzWe0UdBFzhlIcN95VXypLoR8nuz4aX86w+yH6pvrb6chkeKfX7aUhZyWd
8Pc91edQaKNmp53JJEL16rPKAhoW4mOHth9LJCYpCHyUHjIdHw61hCYzegMGritn
JcF/cCkuK7fBfZmFow7UeYGTxSbbZiAZB1p5UJGSJN1QW+gToutlB2N7sE5Ws1r8
drJmJDcq1ThRRj8RhXVZFcJCZWH8lhBWXpueefcuLNLYObkw/0HIendBn0qFnDUk
ijA6OlSlGQ516xJhjRPsom2PcR6JdxMH5g71BsORCewmVnC9BSxXQESmvY+ZEQBO
hVvmd9QIFBTa6gdbcaZb
=PAHa
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
