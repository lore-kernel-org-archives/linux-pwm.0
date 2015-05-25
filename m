From: Tim Kryger <tim.kryger@gmail.com>
Subject: Re: [PATCH v7 3/5] pwm: kona: Fix incorrect config, disable, and
 polarity procedures
Date: Mon, 25 May 2015 10:33:16 -0700
Message-ID: <CAD7vxxKOQgU81x9EHmP=WWq4J30SS2oh1qHVz46iG_bMbSg44w@mail.gmail.com>
References: <1431473296-13683-1-git-send-email-jonathar@broadcom.com>
	<1431473296-13683-4-git-send-email-jonathar@broadcom.com>
	<CAD7vxxLJzjE_yYOV+OtFgq34+Ryhu63YJvpY6Ryi8_=B5z5pLw@mail.gmail.com>
	<555E6119.1030705@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <555E6119.1030705@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Richardson <jonathar@broadcom.com>
Cc: Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PWM <linux-pwm@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Thu, May 21, 2015 at 3:50 PM, Jonathan Richardson
<jonathar@broadcom.com> wrote:

> If this is correct - polarity changes affect the output signal
> immediately, then I can change our driver. Could you confirm first this
> is what we want?

Yes.  This seems best.  Please do.

-Tim
