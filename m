From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [RFC PATCH 4/4] pwm: sun4i: Delay after writing the period
Date: Thu, 9 Apr 2020 23:20:23 +0800
Message-ID: <CAGb2v67GR2x2TJU_MVfD8S=gQO7gv4ohhfGBkLD2CtSCMyNktw@mail.gmail.com>
References: <20200317155906.31288-1-dev@pascalroeleven.nl> <20200317155906.31288-5-dev@pascalroeleven.nl>
Reply-To: wens-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBQ72XT2AKGQEP44AL5A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20200317155906.31288-5-dev-/1Tg0gxlrOS4ObxHbWkkimZHpeb/A1Y/@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Pascal Roeleven <dev-/1Tg0gxlrOS4ObxHbWkkimZHpeb/A1Y/@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Wed, Mar 18, 2020 at 12:00 AM Pascal Roeleven <dev-/1Tg0gxlrOS4ObxHbWkkimZHpeb/A1Y/@public.gmane.org> wrote:
>
> When disabling, ensure the period write is complete before continuing.
> This fixes an issue on some devices when the write isn't complete before
> the panel is turned off but the clock gate is still on.
>
> Signed-off-by: Pascal Roeleven <dev-/1Tg0gxlrOS4ObxHbWkkimZHpeb/A1Y/@public.gmane.org>

Reviewed-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
