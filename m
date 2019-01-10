Return-path: <kernel-bounces@pengutronix.de>
Date: Thu, 10 Jan 2019 09:52:12 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/4] pwm: drop per-chip dbg_show callback
Message-ID: <20190110085212.ngw2uvlh5twhke5z@pengutronix.de>
References: <20190107194938.3004-1-u.kleine-koenig@pengutronix.de>
 <20190107194938.3004-3-u.kleine-koenig@pengutronix.de>
 <20190110083617.GF5213@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190110083617.GF5213@ulmo>
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

On Thu, Jan 10, 2019 at 09:36:17AM +0100, Thierry Reding wrote:
> On Mon, Jan 07, 2019 at 08:49:39PM +0100, Uwe Kleine-K=F6nig wrote:
> > This callback was introduced in commit 62099abf67a2 ("pwm: Add debugfs
> > interface") in 2012 and up to now there is not a single user. So drop t=
his
> > unused code.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/core.c  | 5 +----
> >  include/linux/pwm.h | 3 ---
> >  2 files changed, 1 insertion(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 253a459fe0d8..3149204567f3 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -1036,10 +1036,7 @@ static int pwm_seq_show(struct seq_file *s, void=
 *v)
> >  		   dev_name(chip->dev), chip->npwm,
> >  		   (chip->npwm !=3D 1) ? "s" : "");
> > =20
> > -	if (chip->ops->dbg_show)
> > -		chip->ops->dbg_show(chip, s);
> > -	else
> > -		pwm_dbg_show(chip, s);
> > +	pwm_dbg_show(chip, s);
> > =20
> >  	return 0;
> >  }
> > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > index d5199b507d79..2730725f6d88 100644
> > --- a/include/linux/pwm.h
> > +++ b/include/linux/pwm.h
> > @@ -272,9 +272,6 @@ struct pwm_ops {
> >  		     struct pwm_state *state);
> >  	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
> >  			  struct pwm_state *state);
> > -#ifdef CONFIG_DEBUG_FS
> > -	void (*dbg_show)(struct pwm_chip *chip, struct seq_file *s);
> > -#endif
>=20
> I edited the patch to remove the kerneldoc for this function as well.

Oh, I missed that, thanks for that catch.

Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
