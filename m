Return-path: <kernel-bounces@pengutronix.de>
Date: Thu, 10 Jan 2019 09:36:17 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20190110083617.GF5213@ulmo>
References: <20190107194938.3004-1-u.kleine-koenig@pengutronix.de>
 <20190107194938.3004-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="O98KdSgI27dgYlM5"
Content-Disposition: inline
In-Reply-To: <20190107194938.3004-3-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/4] pwm: drop per-chip dbg_show callback
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


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 08:49:39PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> This callback was introduced in commit 62099abf67a2 ("pwm: Add debugfs
> interface") in 2012 and up to now there is not a single user. So drop this
> unused code.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c  | 5 +----
>  include/linux/pwm.h | 3 ---
>  2 files changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 253a459fe0d8..3149204567f3 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -1036,10 +1036,7 @@ static int pwm_seq_show(struct seq_file *s, void *=
v)
>  		   dev_name(chip->dev), chip->npwm,
>  		   (chip->npwm !=3D 1) ? "s" : "");
> =20
> -	if (chip->ops->dbg_show)
> -		chip->ops->dbg_show(chip, s);
> -	else
> -		pwm_dbg_show(chip, s);
> +	pwm_dbg_show(chip, s);
> =20
>  	return 0;
>  }
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index d5199b507d79..2730725f6d88 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -272,9 +272,6 @@ struct pwm_ops {
>  		     struct pwm_state *state);
>  	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
>  			  struct pwm_state *state);
> -#ifdef CONFIG_DEBUG_FS
> -	void (*dbg_show)(struct pwm_chip *chip, struct seq_file *s);
> -#endif

I edited the patch to remove the kerneldoc for this function as well.

Thierry

--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw3BAEACgkQ3SOs138+
s6GiPg//ftV4b6cLlKu8X5cJj+7VvqNNyyxlaWoevGe73lLWFsKCHV3ELgFinUAY
iYp2nMhVJy/55krzGox5S7+03CXAHlMOtyiULxe9QVPkfVnes2/+wuukKtXeFoCH
aNqODRd+/kigM8+0/3DLwuGR9AYZwrbnakgDtZ34+UQT3iDbHiitMbs/P64v44S1
IGm45rs/tYfQ4dfQqw/Z8WmwYd3XxcqkJIBtpfGAoMbsQsVLenFp9InFSHUtRZdj
uwxnwwfAB2tHeXtqjHcWTVP/9w7uyVUgy9nO2fDz3fnYyaP46DmfdrqIFmcvC3SH
PKkAQXRH0F3m0zONXT1OKdKJngBI4J2MoYXVVmSq27vfhp0vr2Ac1/oF6eyNM/iE
/pVUvJvDT7R5jOSXmIy36/VcyOmve6bUbk8wK6Pkvm9V3wl2gs9IOUt7H1ni3Xrc
BaPrxp07vam5SOz0rRjHWt9U7jG0grlQVQDfMuFjR0COI08doNb0V9V9fsQfCp27
JIfcqyr0Mcw2KZILYvks/rbUl6ulGTBIId/81LK7LHYcC6uslb8x0AVKhwwzzX1H
+o0wGePbON5gbsxBIuMFjQPyDdl49QUKx/nkJDk9fMzGthRaUD0ltqYr2dVuh8hw
QUCYjKvNFiIttl3tUVYW+iOrAEzYc6NL9EGPmUDjh0ExrMV+V10=
=LeyF
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--
