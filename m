From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3 2/7] pwm: rockchip: Remove the judge from return value
 of pwm_config
Date: Fri, 18 Aug 2017 09:28:31 -0700
Message-ID: <20170818162830.GA115593@google.com>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
 <1502206715-24174-3-git-send-email-david.wu@rock-chips.com>
 <20170818153255.GC18307@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170818153255.GC18307@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: David Wu <david.wu@rock-chips.com>, heiko@sntech.de, boris.brezillon@free-electrons.com, robh+dt@kernel.org, catalin.marinas@arm.com, dianders@chromium.org, mark.rutland@arm.com, huangtao@rock-chips.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Fri, Aug 18, 2017 at 05:32:55PM +0200, Thierry Reding wrote:
> I don't understand what the "judge" is supposed to be, but I've applied
> this to for-4.14/drivers anyway. Thanks.

Probably just an artifact of non-native English.

Judging by context, David probably meant more like "Remove the check for
the return value". I believe I've seen other non-native English speakers
use "judge" in a way similar to "check" or "test" in the context of
comparisons and error checking. (A search through my mailbox for "judge"
confirms this.)

Regards,
Brian
