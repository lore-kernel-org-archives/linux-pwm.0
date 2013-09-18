Return-Path: <linux-arm-kernel-bounces+thierry.reding=gmail.com@lists.infradead.org>
From: Boris BREZILLON <b.brezillon@overkiz.com>
Subject: [PATCH 0/2] pwm: atmel-tcb: config fixes
Date: Wed, 18 Sep 2013 17:05:20 +0200
Message-Id: <1379516720-23289-1-git-send-email-b.brezillon@overkiz.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+thierry.reding=gmail.com@lists.infradead.org
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Boris BREZILLON <b.brezillon@overkiz.com>

Hello,

This patch series fix 2 bugs regarding the pwm configuration:
 - the clock source of the timer channel is never applied
 - the maximum time that can be represented when using the slow clock may be
   wrong if the tc block provide a 32 bits width counter

Best Regards,

Boris

Boris BREZILLON (2):
  pwm: atmel-tcb: add missing clk source config
  pwm: atmel-tcb: fix max time computation for slow clk source

 drivers/pwm/pwm-atmel-tcb.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
