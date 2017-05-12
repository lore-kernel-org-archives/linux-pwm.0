From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: Re: [PATCH v2 0/8] r8a7795/6 Salvator-X PWM enablement
Date: Fri, 12 May 2017 12:36:50 +0200
Message-ID: <CAO3366w2JtF9Ni6_yzuQs7-dEy=LNFSekOyiA9YJbHHvvpPLzQ@mail.gmail.com>
References: <1493303863-23719-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <20170512091636.GG27979@verge.net.au> <4398514.qBghdda7X5@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <4398514.qBghdda7X5@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Horman <horms@verge.net.au>, geert@glider.be, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Fri, May 12, 2017 at 12:00 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> * arm64: dts: r8a7795-salvator-x: Enable PWM2
>
> I've asked Ulrich for a clarification on this patch as I'm not sure it's
> needed, but he hasn't answered yet. Could we delay merging it until the
> situation is clarified ?

Enabling it allows to control the switching frequency from userspace
via sysfs. I guess it's a matter of taste whether to do this by
default, but I see no downside to it.

CU
Uli
