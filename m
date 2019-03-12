Return-path: <kernel-bounces@pengutronix.de>
Date: Tue, 12 Mar 2019 13:03:55 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: poke users of legacy drivers with a warning
Message-ID: <20190312120355.dfpcmuetcr56klbp@pengutronix.de>
References: <20190312094249.27806-1-u.kleine-koenig@pengutronix.de>
 <20190312113944.GI31026@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190312113944.GI31026@ulmo>
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

On Tue, Mar 12, 2019 at 12:39:44PM +0100, Thierry Reding wrote:
> On Tue, Mar 12, 2019 at 10:42:49AM +0100, Uwe Kleine-K=F6nig wrote:
> > As it is hard to convert a given driver from the legacy functions
> > (.enable, .disable, .config) to the atomic stuff (.apply) without
> > testing make users aware that there is something to do with a warning to
> > eventually get rid of the legacy drivers.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/core.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> I don't think that's a good idea. What are regular users supposed to do
> when they see this warning?

Ask on this list for directions or volunteer as tester. Then in a few
years we can as a next step make these drivers fail to probe if they are
still unfixed. If you don't agree I wonder how you want to complete the
task to convert all drivers to the atomic API.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
