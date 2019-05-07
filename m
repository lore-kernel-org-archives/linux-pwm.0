From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH v11 0/2] PWM support for HiFive Unleashed
Date: Tue, 07 May 2019 11:39:31 +0200
Message-ID: <mvmlfzisiwc.fsf@suse.de>
References: <1553508779-9685-1-git-send-email-yash.shah@sifive.com>
        <mvmbm1zueya.fsf@suse.de> <mvmpnqcsn6u.fsf@suse.de>
        <CAJ2_jOFu-yCZV_A4B48_fLq7h7UA6LUWhgpxr0uuh7vhW9Q8pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJ2_jOFu-yCZV_A4B48_fLq7h7UA6LUWhgpxr0uuh7vhW9Q8pA@mail.gmail.com>
        (Yash Shah's message of "Thu, 2 May 2019 09:31:16 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Yash Shah <yash.shah@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-pwm@vger.kernel.org

On Mai 02 2019, Yash Shah <yash.shah@sifive.com> wrote:

> The PWM default output state is high (When duty cycle is 0), So I
> guess leds will remain on by default.

So that's the bug that needs to be fixed.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
