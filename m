From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: bcm-iproc: prevent unloading the driver module
 while in use
Date: Thu, 24 Oct 2019 09:36:07 +0200
Message-ID: <20191024073607.fs33i2rztfjqmvfj@pengutronix.de>
References: <20191017192218.9042-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191017192218.9042-1-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-pwm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello,

On Thu, Oct 17, 2019 at 09:22:18PM +0200, Uwe Kleine-K=F6nig wrote:
> The owner member of struct pwm_ops must be set to THIS_MODULE to
> increase the reference count of the module such that the module cannot
> be removed while its code is in use.
> =

> Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Assuming you will send another PR to Linus for 5.4 with the revert of
01ccf903edd65f6421612321648fa5a7f4b7cb10 I suggest to add this patch,
too.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
