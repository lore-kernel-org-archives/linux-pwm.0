From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 2/4] pwm: rockchip: Allow polarity invert on rk3288
Date: Wed, 20 Aug 2014 14:29:17 -0500
Message-ID: <387c82a0-efeb-431d-b8a5-200f24bc47ff@email.android.com>
References: <1408464476-28316-1-git-send-email-dianders@chromium.org> <1408464476-28316-3-git-send-email-dianders@chromium.org> <20140820100447.GG15414@ulmo> <CAD=FV=U9gOiY=4s7WmAQcm0n9s67nWdqQ3A0L2B7Dg83dNotjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=U9gOiY=4s7WmAQcm0n9s67nWdqQ3A0L2B7Dg83dNotjQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Caesar Wang <caesar.wang@rock-chips.com>, Sonny Rao <sonnyrao@chromium.org>, Olof Johansson <olof@lixom.net>, Eddie Cai <eddie.cai@rock-chips.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pwm <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, hpa@zytor.com
List-Id: linux-pwm@vger.kernel.org

On August 20, 2014 1:54:11 PM CDT, Doug Anderson <dianders@chromium.org> wrote:
>On Wed, Aug 20, 2014 at 3:04 AM, Thierry Reding
><thierry.reding@gmail.com> wrote:
>> On Tue, Aug 19, 2014 at 09:07:54AM -0700, Doug Anderson wrote:
>>> The rk3288 has the ability to invert 
>>> +     struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
>>> +
>>> +     if (!pc->data->has_invert)
>>> +             return -ENOSYS;
>>> +

At the kernel summit hpa also mentioned that ENOSYS should only be used for missing syscalls. Not sure what error code would suit better here though...


Thanks.

-- 
Dmitry
