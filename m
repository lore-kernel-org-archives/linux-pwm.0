From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH v8 0/2] PWM support for HiFive Unleashed
Date: Mon, 04 Mar 2019 12:09:57 +0100
Message-ID: <mvmfts228vu.fsf@suse.de>
References: <1551437599-29509-1-git-send-email-yash.shah@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551437599-29509-1-git-send-email-yash.shah@sifive.com> (Yash
        Shah's message of "Fri, 1 Mar 2019 16:23:17 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Yash Shah <yash.shah@sifive.com>
Cc: palmer@sifive.com, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com, paul.walmsley@sifive.com
List-Id: linux-pwm@vger.kernel.org

On Mär 01 2019, Yash Shah <yash.shah@sifive.com> wrote:

> This patch series adds a PWM driver and DT documentation
> for HiFive Unleashed board. The patches are mostly based on
> Wesley's patch.

That doesn't appear to work with the heartbeat trigger, the led doesn't
flash.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
