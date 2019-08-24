From: Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 0/3] pwm: bcm2835: Minor fixes
Date: Sat, 24 Aug 2019 16:09:45 +0200
Message-ID: <1566655788-24949-1-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-pwm@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

This small patch series contains minor fixes for clock handling and the
period range check.

Changes in V2:
- simplified patch 3 inspired by Uwe's suggestion
- add Uwe's Ack

Stefan Wahren (3):
  pwm: bcm2835: suppress error message for invalid period_ns
  pwm: bcm2835: fix period_ns range check
  pwm: bcm2835: suppress error message during deferred probe

 drivers/pwm/pwm-bcm2835.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--
2.7.4
