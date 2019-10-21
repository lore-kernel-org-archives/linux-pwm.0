From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: pwm_bl on i.MX6Q broken on 5.4-RC1+
Date: Mon, 21 Oct 2019 12:11:26 +0200
Message-ID: <20191021101126.tw5bjyp76rbxudgj@pengutronix.de>
References: <CAHCN7xJSz+QhOb4vE6b67jh5jnSOHnw79EyX8RW91TqPkD__Lw@mail.gmail.com>
 <20191020182428.76l3ob4sxblrjr4m@core.my.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191020182428.76l3ob4sxblrjr4m@core.my.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>, arm-soc <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Hello Ondřej,

On Sun, Oct 20, 2019 at 08:24:28PM +0200, Ondřej Jirman wrote:
> On Wed, Oct 16, 2019 at 02:55:54PM -0500, Adam Ford wrote:
> > I have an i.MX6Q with an LCD and PWM controlled backlight.  On 5.4-RC1
> > through the current master (16 Oct 2019), the backlight does not come
> > on by default.  I can get it come on by manually setting the
> > brightness, but any video activity seems to blank the screen again
> > until I change the brightness again.
> 
> You might want to check PWM driver that's used on your SoC. I had a similar
> breakage on Allwinner SoCs, and it was caused by a broken get_state callback.
> The problem was there for a long time and it was only exposed by the commit you
> bisected to.

I added Adam to the recipents of the Thread "backlight: pwm_bl:
configure pwm only once per backlight toggle" here on this list. In this
thread the problem is analysed and it's a bit different than for sun4i.
I assume we don't need to follow up on this report given the discussion
is already ongoing elsewhere.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
