Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46847 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfJPKwl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 06:52:41 -0400
Date: Wed, 16 Oct 2019 12:52:38 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20191016105238.sih4pfsy453c4x5q@pengutronix.de>
References: <20191016073842.1300297-1-thierry.reding@gmail.com>
 <20191016073842.1300297-3-thierry.reding@gmail.com>
 <20191016083107.fetprdj7k52hkdvy@pengutronix.de>
 <20191016095042.GB1303817@ulmo>
 <ebb69ed6-8565-9b55-c66d-5a5cc9a9622f@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ebb69ed6-8565-9b55-c66d-5a5cc9a9622f@st.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 2/3] pwm: stm32: Remove confusing bitmask
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

On Wed, Oct 16, 2019 at 12:20:17PM +0200, Fabrice Gasnier wrote:
> On 10/16/19 11:50 AM, Thierry Reding wrote:
> > On Wed, Oct 16, 2019 at 10:31:07AM +0200, Uwe Kleine-K=F6nig wrote:
> >> On Wed, Oct 16, 2019 at 09:38:41AM +0200, Thierry Reding wrote:
> >>> Both BKP bits are set in the BDTR register and the code relies on the
> >>> mask used during write to make sure only one of them is written. Since
> >>> this isn't immediately obvious, a comment is needed to explain it. The
> >>> same can be achieved by making explicit what happens, so add another
> >>> temporary variable that contains only the one bit that is actually OR=
ed
> >>> into the register and get rid of the comment.
> >>>
> >>> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> >>> ---
> >>>  drivers/pwm/pwm-stm32.c | 10 ++++------
> >>>  1 file changed, 4 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> >>> index b12fb11b7a55..8f1f3371e1dd 100644
> >>> --- a/drivers/pwm/pwm-stm32.c
> >>> +++ b/drivers/pwm/pwm-stm32.c
> >>> @@ -493,26 +493,24 @@ static const struct pwm_ops stm32pwm_ops =3D {
> >>>  static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
> >>>  				    int index, int level, int filter)
> >>>  {
> >>> -	u32 bke, shift, mask, bdtr;
> >>> +	u32 bke, bkp, shift, mask, bdtr;
> >>> =20
> >>>  	if (index =3D=3D 0) {
> >>>  		bke =3D TIM_BDTR_BKE;
> >>> +		bkp =3D TIM_BDTR_BKP;
> >>>  		shift =3D TIM_BDTR_BKF_SHIFT;
> >>>  		mask =3D TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDTR_BKF;
> >>>  	} else {
> >>>  		bke =3D TIM_BDTR_BK2E;
> >>> +		bkp =3D TIM_BDTR_BK2P;
> >>>  		shift =3D TIM_BDTR_BK2F_SHIFT;
> >>>  		mask =3D TIM_BDTR_BK2E | TIM_BDTR_BK2P | TIM_BDTR_BK2F;
> >>
> >> Assuming in the else branch index is always 1, the following would be
> >> IMHO nicer:
> >>
> >> #define TIM_BDTR_BKE(i) BIT(12 + 12 * (i))
> >> #define TIM_BDTR_BKP(i) BIT(13 + 12 * (i))
> >> #define TIM_BDTR_BKF_SHIFT(i) (16 + 4 * (i))
> >>
> >> ..
> >>
> >> 	bke =3D TIM_BDTR_BKE(index);
> >> 	bkp =3D TIM_BDTR_BKP(index);
> >=20
> > I had thought about that, but ultimately decided against it because
> > the original defines might match exactly what's in the datasheet, so
> > there's some value to keep the originals.
> >=20
> > I suppose one other alternative would be to let the macros be and do the
> > computations in the driver instead, something like:
> >=20
> > 	bke =3D TIM_BDTR_BKE << (index * 12);
> > 	bkp =3D TIM_BDTR_BKP << (index * 12);
> > 	bkf =3D TIM_BDTR_BKF << (index *  4);
> >=20
> > But yeah, I agree that having the parameters be part of the macros is
> > even better.
> >=20
> > Fabrice, any objection to redefining the macros as above?
>=20
> Hi Thierry,
>=20
> No objection from me, it will probably improve readability.
>=20
> I'd just suggest an alternative to this: maybe a simple struct array
> with two entries can improve readability ? E.g. keep the defines
> matching the datasheet, and get rid of the conditional code ?
>=20
> Dirty proposal:
>=20
> static const struct stm32_pwm_brk[] =3D {
> 	/* {bke, bkp, shift, mask} */
> 	{ TIM_BDTR_BKE, TIM_BDTR_BKP, ...},
> 	{ TIM_BDTR_BK2E, TIM_BDTR_BK2P, ...},
> }
>=20
> and use "index" to index it ?
>=20
> But I'm fine with the macros as well: there's already similar things in
> this driver to deal with the channels for instance.

I didn't test but I wouldn't be surprised if the compiler could better
optimize the solution I suggested. Might be worth a test however.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
