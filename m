Return-path: <kernel-bounces@pengutronix.de>
Date: Thu, 25 Oct 2018 21:45:24 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: is pwm_put supposed to stop a PWM?
Message-ID: <20181025194524.2xdhqni666zfgfzp@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>, Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de, Boris Brezillon <boris.brezillon@bootlin.com>
List-ID: <linux-pwm.vger.kernel.org>

Hello,

while digging around in the pwm drivers I found
drivers/pwm/pwm-lpc18xx-sct.c which in its .free callback calls
pwm_disable() and pwm_set_duty_cycle(pwm, 0).

I think calling pwm_disable is wrong for two reasons:

 a) pwm_disable is for PWM users, not for drivers
 b) .free isn't supposed to stop the pwm.

Also I'm surprised that .request calls pwm_get_duty_cycle() and writes
the result into hardware. Still more as I think pwm_get_duty_cycle()
always returns 0 in .request.

BTW, this is the only caller of pwm_set_duty_cycle(), so if the driver
is simplified/fixed to not care about the duty cycle in .free and
.request, this function can go away.

What do you think?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
