Return-Path: <laurent.pinchart@ideasonboard.com>
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 0/5] Renesas TPU PWM support
Date: Mon, 17 Jun 2013 12:31:39 +0200
Message-ID: <1401873.dJyJ3o5vr2@avalon>
In-Reply-To: <20130617042441.GA3725@verge.net.au>
References: <1371142488-2514-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20130614010118.GC7284@verge.net.au> <20130617042441.GA3725@verge.net.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: Simon Horman <horms@verge.net.au>
Cc: linux-sh@vger.kernel.org, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Magnus Damm <magnus.damm@gmail.com>

Hi Simon,

On Monday 17 June 2013 13:25:49 Simon Horman wrote:
> Hi Laurent,
> 
> I am having a little trouble testing this.
> I am wondering if you could guide me as to
> what .config options I should have enabled and
> what values I should be looking for in /sys ?

Sure. You need to enable CONFIG_LEDS_PWM and CONFIG_PWM_RENESAS_TPU). You 
should then be able to control the LEDs through /sys/class/leds/*.

-- 
Regards,

Laurent Pinchart
