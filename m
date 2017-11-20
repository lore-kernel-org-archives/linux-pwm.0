From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] pwm: imx: Allow keeping the PWM active during suspend
Date: Mon, 20 Nov 2017 20:41:06 -0200
Message-ID: <CAOMZO5CDyY4efCYQ+0Z4EohHwWaK1MSrX5LP7AZ9ZYC4fRAVyQ@mail.gmail.com>
References: <1511015768-14140-1-git-send-email-festevam@gmail.com> <20171120211932.ro3ybgo6ih2542m2@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171120211932.ro3ybgo6ih2542m2@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, Nov 20, 2017 at 7:19 PM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> Seems to me the default behavior should be LEDs are off in suspend and
> you'd add a property to enable them if desired.
>
> You problem to me sounds like something that should be fixed in the pwm
> and/or pwm-led drivers.

pwm-leds does set brightness to 0 in suspend and the fix here is to
make  pwm-imx active during suspend, so that when pwm-leds sets the
brightness to 0, then pwm-imx really goes to logic level 1.

Please note that on imx6qdl-cuboxi the pwm is active low.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
