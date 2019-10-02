Return-path: <kernel-bounces@pengutronix.de>
Date: Wed, 2 Oct 2019 09:35:47 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH RFC] pwm: add debug knob to help driver authors
Message-ID: <20191002073547.kst4pql7nflqpacg@pengutronix.de>
References: <20190815093839.23710-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190815093839.23710-1-u.kleine-koenig@pengutronix.de>
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
Cc: linux-pwm@vger.kernel.org, Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, kernel@pengutronix.de, Baolin Wang <baolin.wang@linaro.org>
List-ID: <linux-pwm.vger.kernel.org>

Hello Thierry,

On Thu, Aug 15, 2019 at 11:38:39AM +0200, Uwe Kleine-K=F6nig wrote:
> This patch adds some additional checks to the pwm core that help getting
> the details right. The check about rounding isn't approved yet, but I
> consider that sensible as it helps consistency when all drivers round in
> the same direction. The other checks are in line with what I understood
> are the intended requirements.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> this patch is only compile tested up to now but still I think it adds
> useful diagnostics for driver authors that helps even more than an exact
> documentation. Feedback welcome.

do you consider the idea here worthwile? If so I'd update the patch to
current mainline and address the feedback I got so far.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
