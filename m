From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: bcm2835: increase precision of pwm
Date: Sun, 2 Jun 2019 16:35:11 +0200
Message-ID: <20190602143511.o777ozvxuh5xey7o@pengutronix.de>
References: <20190602102350.zzwmfvlky3mnlqln@gofer.mess.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190602102350.zzwmfvlky3mnlqln@gofer.mess.org>
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, linux-pwm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Sean Young <sean@mess.org>, Scott Branden <sbranden@broadcom.com>, Andreas Christ <andreas@christ-faesch.ch>, Ray Jui <rjui@broadcom.com>, Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello Thierry,

On Sun, Jun 02, 2019 at 11:23:50AM +0100, Sean Young wrote:
> If sending IR with carrier of 455kHz using the pwm-ir-tx driver, the
> carrier ends up being 476kHz.
> =

> A carrier of 455kHz has a period of 2198ns, but the arithmetic truncates
> this to 2.1ns rather than 2.2ns. So, use DIV_ROUND_CLOSEST() to reduce
> rounding errors, and we have a much more accurate carrier of 454.5kHz.

can we please fix the rules how to round such that not every driver
invents its own measurement of what is best?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
