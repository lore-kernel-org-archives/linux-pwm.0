From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 0/2] ARM: adapt defconfigs to pwm driver split
Date: Fri, 22 Mar 2019 09:57:13 +0800
Message-ID: <20190322015711.GV12513@dragon>
References: <20190107195352.3149-5-u.kleine-koenig@pengutronix.de>
 <20190110201934.4105-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190110201934.4105-1-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On Thu, Jan 10, 2019 at 09:19:32PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
> =

> to continue compiling the (now) two pwm-imx drivers as part of the
> imx defconfigs we should update them to use the new names.
> =

> I think the easiest handling would be to let them go via the pwm tree
> with Shawn's Ack to get the update near to the actual split into
> the mainline.
> =

> Best regards
> Uwe
> =

> Uwe Kleine-K=F6nig (2):
>   ARM: imx_v6_v7_defconfig: continue compiling the pwm driver
>   ARM: imx_v4_v5_defconfig: enable PWM driver

Applied for 5.1-rc, thanks.
