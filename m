From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: lpc18xx-sct: don't reconfigure PWM in .request and
 .free
Date: Fri, 16 Nov 2018 10:48:02 +0100
Message-ID: <20181116094802.5qpaygab5epnmwp5@pengutronix.de>
References: <20181114115025.GC2620@ulmo>
 <20181116065208.3920-1-u.kleine-koenig@pengutronix.de>
 <1391bbe1-75b5-c86e-ed3a-1e1afb393917@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1391bbe1-75b5-c86e-ed3a-1e1afb393917@mleia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On Fri, Nov 16, 2018 at 11:22:49AM +0200, Vladimir Zapolskiy wrote:
> Hello Uwe,
> =

> On 11/16/2018 08:52 AM, Uwe Kleine-K=F6nig wrote:
> > Regarding the .request case: The consumer might be interested in taking
> > over the configured state from the boot loader. So the initially
> > configured state should be retained.
> > =

> > For the free case the PWM consumer is responsible to disable the PWM
> > before calling pwm_release and there are three subcases to consider:
> > =

> =

> the changes are fine per se, but please split them into two.
> =

> Probably pwm_disable() misusage began spreading from commit 54b2a999a1675.

I see little benefit, but if that's the only problem I can split.

Note that the behaviours of .request and .free are not unrelated.
Currently because .free sets a duty cycle of 0 we have
pwm_get_duty_cycle always return 0 in .request.

Waiting on what Thierry thinks.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
