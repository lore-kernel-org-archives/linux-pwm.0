From: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [v3 5/7] pwm: crc: Add Crystalcove (CRC) PWM driver
Date: Fri, 26 Jun 2015 18:01:53 +0530
Message-ID: <558D4639.8000102@gmail.com>
References: <1435309330-50725-1-git-send-email-shobhit.kumar@intel.com>
 <1435309330-50725-6-git-send-email-shobhit.kumar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1435309330-50725-6-git-send-email-shobhit.kumar@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Shobhit Kumar <shobhit.kumar@intel.com>, linux-pwm <linux-pwm@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Paul Bolle <pebolle@tiscali.nl>, Samuel Ortiz <sameo@linux.intel.com>, Povilas Staniulis <wdmonster@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, bloften80@gmail.com, David Airlie <airlied@linux.ie>, Chih-Wei Huang <cwhuang@android-x86.org>, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

T24gMDYvMjYvMjAxNSAwMjozMiBQTSwgU2hvYmhpdCBLdW1hciB3cm90ZToKPiBUaGUgQ3J5c3Rh
bGNvdmUgUE1JQyBwcm92aWRlcyB0aHJlZSBQV00gc2lnbmFscyBhbmQgdGhpcyBkcml2ZXIgZXhw
b3J0cwo+IG9uZSBvZiB0aGVtIG9uIHRoZSBCWVQgcGxhdGZvcm0gd2hpY2ggaXMgdXNlZCB0byBj
b250cm9sIGJhY2tsaWdodCBmb3IKPiBEU0kgcGFuZWwuIFRoaXMgaXMgcGxhdGZvcm0gZGV2aWNl
IGltcGxlbWVudGF0aW9uIG9mIHRoZSBkcml2ZXJzL21mZAo+IGNlbGwgZGV2aWNlIGZvciBDUkMg
UE1JQy4KPgo+IENDOiBTYW11ZWwgT3J0aXogPHNhbWVvQGxpbnV4LmludGVsLmNvbT4KPiBDYzog
TGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPgo+IENjOiBBbGV4YW5kcmUg
Q291cmJvdCA8Z251cm91QGdtYWlsLmNvbT4KPiBDYzogVGhpZXJyeSBSZWRpbmcgPHRoaWVycnku
cmVkaW5nQGdtYWlsLmNvbT4KPiBDYzogUGF1bCBCb2xsZSA8cGVib2xsZUB0aXNjYWxpLm5sPgo+
IENjOiBQYXVsIEdvcnRtYWtlciA8cGF1bC5nb3J0bWFrZXJAd2luZHJpdmVyLmNvbT4KPiBUZXN0
ZWQtYnk6IFZpbGxlIFN5cmrDpGzDpCA8dmlsbGUuc3lyamFsYUBsaW51eC5pbnRlbC5jb20+Cj4g
U2lnbmVkLW9mZi1ieTogU2hvYmhpdCBLdW1hciA8c2hvYmhpdC5rdW1hckBpbnRlbC5jb20+Cj4g
LS0tCj4gdjI6IFVzZSB0aGUgZXhpc3RpbmcgY29uZmlnIGNhbGxiYWNrIHdpdGggZHV0eV9ucyBh
bmQgcGVyaW9kX25zKFRoaWVycnkpCj4KPiB2MzogQ29ycmVjdCB0aGUgc3ViamVjdCBsaW5lIChM
ZWUgam9uZXMpCj4KPiB2NDogQWRkcmVzcyBjb21tZW50IGJ5IFRoaWVycnkgJiBQYXVsCj4gICAg
ICAtIENvbW1pdCBtZXNzYWdlIHVwZGF0ZSBhbmQgZml4ZXMgZm9yIGZldyBzeW50YXggZXJyb3Jz
Cj4gICAgICAtIEFkZCBQV01fQ1JDIGluIEtjb25maWcgYW5kIE1ha2VmaWxlIHNvcnRlZCBhbHBo
YWJldGljYWxseQo+ICAgICAgLSBVc2UgdGhlIFBXTV9CQVNFX0NMSyBhcyA2MDAwMDAwIGZvciBi
ZXR0ZXIgY29kZSByZWFkYWJpbGl0eQo+ICAgICAgLSBSZW1vdmUgdGhlIHJlZHVuZGFudCBydWxl
IG9mIHRocmVlIHdoaWxlIGNhbGN1bGF0aW5nIHB3bSBsZXZlbAo+ICAgICAgLSBVc2UgdGhlIHBs
YXRmb3JtX2RldmljZSBpbiBwd21fY2hpcAo+ICAgICAgLSBVc2UgYnVpbGluX3BsYXRmb3JtX2Ry
aXZlcgo+Cj4gdjU6IEFkZHJlc3MgY29tbWVudHMgYnkgVmFya2EKPiAgICAgIC0gTWFrZSB0aGUg
Yml0IGRlZmluaXRpb24gdXNpbmcgQklUIG1hY3JvCj4gICAgICAtIHJlb3JkZXIgcHJvYmUgYW5k
IHJlbW92ZSBjb2RlIHRvIGRpcmVjdGx5IHJldHVybiBmcm9tIHB3bWNoaXBfYWRkL3JlbW92ZQo+
Cj4gICBkcml2ZXJzL3B3bS9LY29uZmlnICAgfCAgIDcgKysrCj4gICBkcml2ZXJzL3B3bS9NYWtl
ZmlsZSAgfCAgIDEgKwo+ICAgZHJpdmVycy9wd20vcHdtLWNyYy5jIHwgMTQzICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gICAzIGZpbGVzIGNoYW5n
ZWQsIDE1MSBpbnNlcnRpb25zKCspCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wd20v
cHdtLWNyYy5jCgpSZXZpZXdlZC1ieTogVmFya2EgQmhhZHJhbSA8dmFya2FiaGFkcmFtQGdtYWls
LmNvbT4KCi0tIApCZXN0IHJlZ2FyZHMsClZhcmthIEJoYWRyYW0uCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0Cklu
dGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
