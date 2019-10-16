Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39055 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbfJPIbK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 04:31:10 -0400
Date: Wed, 16 Oct 2019 10:31:07 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20191016083107.fetprdj7k52hkdvy@pengutronix.de>
References: <20191016073842.1300297-1-thierry.reding@gmail.com>
 <20191016073842.1300297-3-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191016073842.1300297-3-thierry.reding@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 2/3] pwm: stm32: Remove confusing bitmask
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org

On Wed, Oct 16, 2019 at 09:38:41AM +0200, Thierry Reding wrote:
> Both BKP bits are set in the BDTR register and the code relies on the
> mask used during write to make sure only one of them is written. Since
> this isn't immediately obvious, a comment is needed to explain it. The
> same can be achieved by making explicit what happens, so add another
> temporary variable that contains only the one bit that is actually ORed
> into the register and get rid of the comment.
>=20
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/pwm-stm32.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index b12fb11b7a55..8f1f3371e1dd 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -493,26 +493,24 @@ static const struct pwm_ops stm32pwm_ops =3D {
>  static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
>  				    int index, int level, int filter)
>  {
> -	u32 bke, shift, mask, bdtr;
> +	u32 bke, bkp, shift, mask, bdtr;
> =20
>  	if (index =3D=3D 0) {
>  		bke =3D TIM_BDTR_BKE;
> +		bkp =3D TIM_BDTR_BKP;
>  		shift =3D TIM_BDTR_BKF_SHIFT;
>  		mask =3D TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDTR_BKF;
>  	} else {
>  		bke =3D TIM_BDTR_BK2E;
> +		bkp =3D TIM_BDTR_BK2P;
>  		shift =3D TIM_BDTR_BK2F_SHIFT;
>  		mask =3D TIM_BDTR_BK2E | TIM_BDTR_BK2P | TIM_BDTR_BK2F;

Assuming in the else branch index is always 1, the following would be
IMHO nicer:

#define TIM_BDTR_BKE(i) BIT(12 + 12 * (i))
#define TIM_BDTR_BKP(i) BIT(13 + 12 * (i))
#define TIM_BDTR_BKF_SHIFT(i) (16 + 4 * (i))

..

	bke =3D TIM_BDTR_BKE(index);
	bkp =3D TIM_BDTR_BKP(index);

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
