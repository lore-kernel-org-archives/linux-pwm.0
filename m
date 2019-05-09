Return-path: <kernel-bounces@pengutronix.de>
Date: Thu, 9 May 2019 21:02:15 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] pwm: samsung: don't uses devm-functions in .request
Message-ID: <20190509190215.74oj4orkntnpqfws@pengutronix.de>
References: <20190325094934.10221-1-u.kleine-koenig@pengutronix.de>
 <20190325094934.10221-2-u.kleine-koenig@pengutronix.de>
 <20190509152214.GF8907@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190509152214.GF8907@ulmo>
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

On Thu, May 09, 2019 at 05:22:14PM +0200, Thierry Reding wrote:
> On Mon, Mar 25, 2019 at 10:49:34AM +0100, Uwe Kleine-K=F6nig wrote:
> > A call to .request() is always paired by a call to .free() before a giv=
en
> > device is disposed. So the simplification that usually is possible when
> > using devm-functions cannot be used here. So use plain kzalloc() and
> > kfree() for improved runtime behaviour and reduced memory footprint.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/pwm-samsung.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> Applied, and dropped the chip->dev parameter while at it to make this
> actually build.

Huh, thanks for that. I'm surprised I didn't notice that myself.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
