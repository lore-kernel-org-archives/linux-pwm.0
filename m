From: Jonathan Liu <net147@gmail.com>
Subject: Re: [1/2] pwm: sunxi: allow the pwm to finish its pulse before disable
Date: Fri, 5 May 2017 11:54:32 +1000
Message-ID: <CANwerB2uB6m6VreZgSJvROR=E5Ap2OFj6zrcLQQ7CZYxWjbi+A@mail.gmail.com>
References: <1472147411-30424-2-git-send-email-oliver@schinagl.nl>
 <CANwerB2LwWShNEUmNNbuH_4GY90gSpVmrxbC+oLK4p51cxUe2g@mail.gmail.com> <d68427df-a3ec-0a74-9bb5-c86ca60a1c2e@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d68427df-a3ec-0a74-9bb5-c86ca60a1c2e@schinagl.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 24 September 2016 at 00:03, Olliver Schinagl <oliver@schinagl.nl> wrote:
> You are welcome, but there's some work still being done in this regard, or
> rather, i have to find time to grab a scope and properly check the output.
> So expect the proper fix to be coming to a kernel near you soon :)
>
> Meanwhile, it seems to still confirm that this is needed. Thanks on that.
>
> Olliver

Ping. I see pwm_can_sleep() has been removed in 4.11.
Any updates on this?

Regards,
Jonathan
