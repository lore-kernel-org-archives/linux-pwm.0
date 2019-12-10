From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: sun4i: Narrow scope of local variable
Date: Tue, 10 Dec 2019 11:12:29 +0100
Message-ID: <20191210101229.rvqelc2hanisd2cp@pengutronix.de>
References: <20191002101624.gljyf7g4nia2rcbx@pengutronix.de>
 <20191205072404.6858-1-u.kleine-koenig@pengutronix.de>
 <5DE8C1E3.4080204@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5DE8C1E3.4080204@bfs.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: walter harms <wharms@bfs.de>
Cc: linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, kernel@pengutronix.de, Colin King <colin.king@canonical.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello Walter,

On Thu, Dec 05, 2019 at 09:37:55AM +0100, walter harms wrote:
> Am 05.12.2019 08:24, schrieb Uwe Kleine-K=F6nig:
> > +			unsigned int pval;
> > +
> >  			if (!prescaler_table[prescaler])
> >  				continue;
> >  			pval =3D prescaler_table[prescaler];
> =

> =

> nit picking:
> Doing the assignment first would remove the only use
> of prescaler_table[prescaler].

nit picking: it would be reduced to a single use?!

> unsigned int pval =3D prescaler_table[prescaler];
> if ( ! pval )
>   continue;

Right, will send a v2 with that.

> if you feel adventures you could also replace the for() for a while()
> since we know that prescaler =3D=3D 0.
> =

> while ( prescaler < PWM_PRESCAL_MASK )
> {
> unsigned int pval =3D prescaler_table[prescaler++];
> ....

That however has some side effects as prescaler is used after leaving
the loop.

Best regards
Uwe


-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
