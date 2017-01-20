From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] ARM: dts: da850-lcdk: enable pwm nodes
Date: Fri, 20 Jan 2017 18:23:31 +0530
Message-ID: <8e981b0b-cdff-aed4-b25b-8875465f0bbb@ti.com>
References: <1484586189-3118-1-git-send-email-fisaksen@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1484586189-3118-1-git-send-email-fisaksen@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Frode Isaksen <fisaksen@baylibre.com>, khilman@baylibre.com, ptitiano@baylibre.com, linux-arm-kernel@lists.infradead.org
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com
List-Id: linux-pwm@vger.kernel.org

Hi Frode,

On Monday 16 January 2017 10:33 PM, Frode Isaksen wrote:
> Enable the ecap1 and ecap2 pwm nodes for the
> lcdk board.
> Note that the other pwm nodes are not enabled,
> since the pins are shared with ethernet and spi.
> 
> Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
> ---

Looks like the eCAP is available on the headers at the bottom of the
board. While patch like this is fine to be able to test the PWM
functionality, I dont think we should apply it because this can
potentially clash with usage of the pin on daughter card.

Thanks,
Sekhar
