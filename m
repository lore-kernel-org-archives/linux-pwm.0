From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: lpc18xx-sct: don't reconfigure PWM in .request and
 .free
Date: Fri, 16 Nov 2018 11:45:03 +0100
Message-ID: <20181116104503.he6rykrsqt4whacs@pengutronix.de>
References: <20181114115025.GC2620@ulmo>
 <20181116065208.3920-1-u.kleine-koenig@pengutronix.de>
 <1391bbe1-75b5-c86e-ed3a-1e1afb393917@mleia.com>
 <20181116100114.GB28631@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181116100114.GB28631@ulmo>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Vladimir Zapolskiy <vz@mleia.com>
List-Id: linux-pwm@vger.kernel.org

Hello Thierry,

On Fri, Nov 16, 2018 at 11:01:14AM +0100, Thierry Reding wrote:
> On Fri, Nov 16, 2018 at 11:22:49AM +0200, Vladimir Zapolskiy wrote:
> > On 11/16/2018 08:52 AM, Uwe Kleine-K=F6nig wrote:
> > > Regarding the .request case: The consumer might be interested in taki=
ng
> > > over the configured state from the boot loader. So the initially
> > > configured state should be retained.
> > > =

> > > For the free case the PWM consumer is responsible to disable the PWM
> > > before calling pwm_release and there are three subcases to consider:
> > > =

> > =

> > the changes are fine per se, but please split them into two.
> > =

> > Probably pwm_disable() misusage began spreading from commit 54b2a999a16=
75.
> =

> It's not really misusage to call pwm_disable(). It's basically just a
> shortcut for ->disable() or the atomic equivalent for it.

I'd say that pwm_disable() is not a shortcut but the long way round to
.disable() at best.

And that calling pwm_disable() from the low level driver doesn't result
in problems is just luck because the pwm framework is such a thin
wrapper. If it would do locking, .free might already hold the lock and
pwm_disable might try to grab it again. If it would do more checking
that only a caller of pwm_get calls pwm_disable, the check would trigger
because the consumer already called pwm_put and the lowlevel driver
didn't use pwm_get.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
