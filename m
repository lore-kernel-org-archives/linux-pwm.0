Return-path: <kernel-bounces@pengutronix.de>
Date: Tue, 20 Nov 2018 17:57:58 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] PWM: drop legacy wrapper for changing polarity
Message-ID: <20181120165758.pwprvrhzpftkghap@pengutronix.de>
References: <20181015082152.5900-1-u.kleine-koenig@pengutronix.de>
 <20181104211945.ychhco6vrmuf6jtc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181104211945.ychhco6vrmuf6jtc@pengutronix.de>
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
Cc: linux-pwm@vger.kernel.org, Gavin Schenk <g.schenk@eckelmann.de>, =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

On Sun, Nov 04, 2018 at 10:19:45PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello Thierry,
>=20
> On Mon, Oct 15, 2018 at 10:21:52AM +0200, Uwe Kleine-K=F6nig wrote:
> > The API to configure a PWM using pwm_enable(), pwm_disable(),
> > pwm_config() and pwm_set_polarity() is superseeded by atomically setting
> > the parameters using pwm_apply_state(). To get forward with deprecating
> > the former set of functions use the opportunity that there is no current
> > user of pwm_set_polarity() and remove it.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> I think this patch is undisputed and wonder if it fell through the
> cracks given that a patch sent later made it into your pwm/for-4.20-rc1
> pull request.

Now that you pushed out my lpc patch to your for-next branch (thanks!),
I wonder what you plan to do with this patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
