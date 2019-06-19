From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH v2] pwm: bcm2835: improve precision of pwm
Date: Wed, 19 Jun 2019 07:21:43 +0200
Message-ID: <1c7dc4ba-eb6e-b6da-3bfd-4b872f9c6498@gmx.net>
References: <20190603090058.qd3tbiffmdgqm34d@gofer.mess.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190603090058.qd3tbiffmdgqm34d@gofer.mess.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sean Young <sean@mess.org>
Cc: linux-pwm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Andreas Christ <andreas@christ-faesch.ch>, Ray Jui <rjui@broadcom.com>, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Am 03.06.19 um 11:00 schrieb Sean Young:
> If sending IR with carrier of 455kHz using the pwm-ir-tx driver, the
> carrier ends up being 476kHz. The clock is set to bcm2835-pwm with a
> rate of 10MHz.
>
> A carrier of 455kHz has a period of 2198ns, but the arithmetic truncates
> this to 2100ns rather than 2200ns. So, use DIV_ROUND_CLOSEST() to reduce
> rounding errors, and we have a much more accurate carrier of 454.5kHz.
>
> Reported-by: Andreas Christ <andreas@christ-faesch.ch>
> Signed-off-by: Sean Young <sean@mess.org>
Acked-by: Stefan Wahren <wahrenst@gmx.de>
