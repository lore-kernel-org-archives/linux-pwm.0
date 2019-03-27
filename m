From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH v11 0/2] PWM support for HiFive Unleashed
Date: Wed, 27 Mar 2019 10:04:25 +0100
Message-ID: <mvmpnqcsn6u.fsf@suse.de>
References: <1553508779-9685-1-git-send-email-yash.shah@sifive.com>
        <mvmbm1zueya.fsf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <mvmbm1zueya.fsf@suse.de> (Andreas Schwab's message of "Mon, 25
        Mar 2019 16:54:53 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Yash Shah <yash.shah@sifive.com>
Cc: palmer@sifive.com, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com, paul.walmsley@sifive.com
List-Id: linux-pwm@vger.kernel.org

I have now found out that the ledtrig modules don't load automatically.
I would have expected that the linux,default-trigger entries would cause
the load of the corresponding ledtrig modules.

But there is another problem, that the leds are on by default.
Shouldn't they be off by default?

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
