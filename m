From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCHv5 2/3] pwm: make the PWM_POLARITY flag in DTB optional
Date: Thu, 9 Oct 2014 17:16:08 +0200
Message-ID: <20141009151605.GA8818@ulmo.nvidia.com>
References: <1412690134-13712-1-git-send-email-LW@KARO-electronics.de>
 <1412690134-13712-3-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:57763 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755824AbaJIPQP (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Oct 2014 11:16:15 -0400
Received: by mail-ig0-f180.google.com with SMTP id uq10so4521144igb.7
        for <linux-pwm@vger.kernel.org>; Thu, 09 Oct 2014 08:16:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1412690134-13712-3-git-send-email-LW@KARO-electronics.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, Tony Prisk <linux@prisktech.co.nz>


--Bn2rw/3z4jIqBvZU
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2014 at 03:55:33PM +0200, Lothar Wa=C3=9Fmann wrote:
> Change the pwm chip driver registration, so that a chip driver that
> supports polarity inversion can still be used with DTBs that don't
> provide the 'PWM_POLARITY' flag.
>=20
> This is done to provide polarity inversion support for the pwm-imx
> driver without having to modify all existing DTS files.

I don't like how this throws out the window the only sanity checking we
have in place for the #pwm-cells property.

As I understand it, the problem that you're trying to solve is one of
backwards-compatibility where existing device trees have #pwm-cells =3D
<2>, but the driver is extended to support flags as well.

In that case, can we not simply make of_pwm_xlate_with_flags() support
that case transparently? That is, if the driver sets .of_pwm_n_cells to
3, we can still support #pwm-cells =3D <2> and use the default (no) flags
instead.

Something like the below should do that (compile-tested only).

Thierry

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 966497d10c6e..89a5e309b0a3 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -136,9 +136,14 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const str=
uct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
=20
+	/* check that the driver supports a third cell for flags */
 	if (pc->of_pwm_n_cells < 3)
 		return ERR_PTR(-EINVAL);
=20
+	/* flags in the third cell are optional */
+	if (args->args_count < 2)
+		return ERR_PTR(-EINVAL);
+
 	if (args->args[0] >=3D pc->npwm)
 		return ERR_PTR(-EINVAL);
=20
@@ -148,10 +153,12 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const st=
ruct of_phandle_args *args)
=20
 	pwm_set_period(pwm, args->args[1]);
=20
-	if (args->args[2] & PWM_POLARITY_INVERTED)
-		pwm_set_polarity(pwm, PWM_POLARITY_INVERSED);
-	else
-		pwm_set_polarity(pwm, PWM_POLARITY_NORMAL);
+	if (args->args_count > 2) {
+		if (args->args[2] & PWM_POLARITY_INVERTED)
+			pwm_set_polarity(pwm, PWM_POLARITY_INVERSED);
+		else
+			pwm_set_polarity(pwm, PWM_POLARITY_NORMAL);
+	}
=20
 	return pwm;
 }
@@ -162,9 +169,14 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const struct =
of_phandle_args *args)
 {
 	struct pwm_device *pwm;
=20
+	/* sanity check driver support */
 	if (pc->of_pwm_n_cells < 2)
 		return ERR_PTR(-EINVAL);
=20
+	/* all cells are required */
+	if (args->args_count !=3D pc->of_pwm_n_cells)
+		return ERR_PTR(-EINVAL);
+
 	if (args->args[0] >=3D pc->npwm)
 		return ERR_PTR(-EINVAL);
=20
@@ -536,13 +548,6 @@ struct pwm_device *of_pwm_get(struct device_node *np, =
const char *con_id)
 		goto put;
 	}
=20
-	if (args.args_count !=3D pc->of_pwm_n_cells) {
-		pr_debug("%s: wrong #pwm-cells for %s\n", np->full_name,
-			 args.np->full_name);
-		pwm =3D ERR_PTR(-EINVAL);
-		goto put;
-	}
-
 	pwm =3D pc->of_xlate(pc, &args);
 	if (IS_ERR(pwm))
 		goto put;

--sm4nu43k4a2Rpi4c--

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUNqa1AAoJEN0jrNd/PrOhZnYQAKXzrn1T0DKgUj+x6p3uMkNJ
eJ0icrrtK8mfxx0Gq7J2zv1sAHQTqBr0l/1nhziZwntRmTVMKMHeIN2Fzx1Y3BUl
SknVEU7+0GX+yFkdx0CymP7elrlAjafOJzQLSxPwd55jMXn++/KubHiCzKBc3KWi
vzuXpABX5NfwgHFJEhWSX9Ev38tk/CxqO8IZ6DohiWV89X9c/dm3adv0ZK+EcNSX
g7VIsiAupDBbUXZVNUxOzR4g0aOQsBTo4ueXnsjc56/XEUTQsGXkPfJaPoU+RCQs
bjpsCciCT4Q9kGMvikEsAFRXEvyT29flFIMcOKUBF5n88XeQVrH7VBPbqqeI90Ah
ZfI/oFXMu1bvzrn+Gq5y6cDRHToqKELV/+GKu9Jq9FjeofaIRTwUt0MifUsLOUMM
auU/IEA+nEysuC4CsdDjnjZthNKPF6D+F7kp4c9sj+TK2HyUbgKiF2CMliedmc/I
FO6Nda24jvjsQyN33qBjzLHU2+v+cszJNYooY/wNHz1uqvUt84x+Z4R52/O4DnEa
yv3Tqal21b/F0gD8NybcW7JckFU8asrc6CYfTr6hsPWW+t76D2uBM0mDRXG1FF5u
If+M0IkSyc2c3mM4hXQSltDyl1uqeAhc8kBd8B0tGF4lKD/sFP2ZygZkd7T1S8zT
D1mrNCTGdTtLhY1InWrd
=MR6P
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
