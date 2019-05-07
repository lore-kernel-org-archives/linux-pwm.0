From: Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH v11 0/2] PWM support for HiFive Unleashed
Date: Tue, 7 May 2019 16:31:58 +0530
Message-ID: <CAJ2_jOG2M03aLBgUOgGjWH9CUxq2aTG97eSX70=UaSbGCMMF_g@mail.gmail.com>
References: <1553508779-9685-1-git-send-email-yash.shah@sifive.com>
 <mvmbm1zueya.fsf@suse.de> <mvmpnqcsn6u.fsf@suse.de>
 <CAJ2_jOFu-yCZV_A4B48_fLq7h7UA6LUWhgpxr0uuh7vhW9Q8pA@mail.gmail.com>
 <mvmlfzisiwc.fsf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
In-Reply-To: <mvmlfzisiwc.fsf@suse.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Andreas Schwab <schwab@suse.de>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org, robh+dt@kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Thierry Reding <thierry.reding@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Andreas,
On Tue, May 7, 2019 at 3:09 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On Mai 02 2019, Yash Shah <yash.shah@sifive.com> wrote:
>
> > The PWM default output state is high (When duty cycle is 0), So I
> > guess leds will remain on by default.
>
> So that's the bug that needs to be fixed.

Sorry I didn't probably get you before. I now understood the scenario.

Leds on HiFive Unleashed are wired to supply instead of ground.
And as per ./Documentation/devicetree/bindings/leds/leds-pwm.txt, you
need to provide additional property "active-low" in such case.

- active-low : (optional) For PWMs where the LED is wired to supply
rather than ground.

The leds will remain off by default when you add the "active-low"
property under the pwm-leds subnode in your DT file. So, this isn't a
bug in the driver code.
For DT file change, you may refer
https://github.com/yashshah7/riscv-linux/commit/dd55057a26150e50525643a423b20e07b72617b5

Can you test this at your end and confirm?

- Yash
>
> Andreas.
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> "And now for something completely different."

-- 
The information transmitted is intended only for the person or entity to 
which it is addressed and may contain confidential and/or privileged 
material. If you are not the intended recipient of this message please do 
not read, copy, use or disclose this communication and notify the sender 
immediately. It should be noted that any review, retransmission, 
dissemination or other use of, or taking action or reliance upon, this 
information by persons or entities other than the intended recipient is 
prohibited.
